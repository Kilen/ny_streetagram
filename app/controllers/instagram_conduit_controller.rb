require "net/http"
class InstagramConduitController < ApplicationController
  CLIENT_ID = "5a97d503088d45a8b0ba147771de3787"
  CLIENT_SECRET = "94078e484b09455f8936a3a8658d5ee2"
  
  @@object_id = "0" #for debug

  def feed_reciver
    if updates_from_instagram? && is_receiver_on?
      fetch_new_photo_info
      @@object_id = @json["object_id"]
    end
    render text: "Thank you"
  end

  #for debug
  def show_receives
    @receives = @@object_id == "0" ? { result: "no params" } : { object_id: @@object_id }
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
      store_photo_info
    end
  end

  def store_photo_info
    uri = URI "https://api.instagram.com/v1/geographies/#{@json['object_id']}/media/recent"
    parameters = { client_id: CLIENT_ID }
    uri.query = URI.encode_www_form parameters
    res = Net::HTTP.get_response uri
    if res.is_a? Net::HTTPSuccess
      data = MultiJson.decode(res.body)["data"]
      #TODO data enqueue
    end
  end
end
