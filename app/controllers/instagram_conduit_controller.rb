require "net/http"
class InstagramConduitController < ApplicationController
  CLIENT_ID = "5a97d503088d45a8b0ba147771de3787"
  CLIENT_SECRET = "94078e484b09455f8936a3a8658d5ee2"


  def show_photos_in_map
    session[:cur_photo_count] = Photo.count
    @photos = Photo.last 50
  end

  def new_photos
    render json: pack_new_photo_infos
  end

  ################for debug
  @@object_id = "0"
  def feed_receiver
    store_photo_infos

    #WebsocketRails[:photos].trigger "new", pack_new_photo_infos
    data = ""
    Photo.all.each do |photo|
      data += "###########" + photo.info["location"].to_s
    end
    render text: data
  end

  def show_receives
    @receives = @@object_id == "0" ? { result: "no params" } : { object_id: @@object_id }
  end
  #########################

  def feed_receiver
    if updates_from_instagram? && is_receiver_on?
      fetch_new_photo_info
      @@object_id = @json["object_id"]
    end
    render text: "Thank you"
  end

  def handle_instagram_validation
    render text: params["hub.challenge"] || "success"
  end

  private 

  def updates_from_instagram?
    json = request.body.read
    @json = MultiJson.decode(json)[0]
    digest = OpenSSL::Digest::Digest.new 'sha1'
    OpenSSL::HMAC.hexdigest(digest, CLIENT_SECRET, json) == request.headers["X-Hub-Signature"]
  end

  def is_receiver_on?
    true
  end

  def fetch_new_photo_info
    if @json["object"] == "geography"
      store_photo_infos
    end
  end

  def store_photo_infos
    #uri = URI "http://localhost:4000/instagram/photo_infos" #my local server for debugging
    uri = URI "https://api.instagram.com/v1/geographies/#{@json['object_id']}/media/recent"
    parameters = { client_id: CLIENT_ID }
    uri.query = URI.encode_www_form parameters
    res = Net::HTTP.get_response uri
    if res.is_a? Net::HTTPSuccess
      data = MultiJson.decode(res.body)["data"]
      data.each do |item|
        Photo.create! info: item
      end
    end
  end

  def pack_new_photo_infos
    package = []
    Photo.last(new_record_count).each do |photo|
      package << photo.info
    end
    package.to_json
  end

  def new_record_count
    session[:cur_photo_count] = session[:cur_photo_count] || 0
    count = Photo.count - session[:cur_photo_count]
    session[:cur_photo_count] += count
    count
  end
end

