class InstagramConduitController < ApplicationController
  CLIENT_ID = "5a97d503088d45a8b0ba147771de3787"
  CLIENT_SECRET = "94078e484b09455f8936a3a8658d5ee2"

  def feed_reciver
    if updates_from_instagram?
    end
    render text: "Thank you"
  end

  def show_receives
    media = Media.last
    @receives = media.nil? ? { result: "no params" } : JSON.parse(media.receives) 
  end

  def handle_instagram_validation
    render text: params["hub.challenge"] || "success"
  end

  private 

  def updates_from_instagram?
    json = request.body.read
    @json = MultiJson.decode json
    digest = OpenSSL::Digest::Digest.new 'sha1'
    OpenSSL::HMAC.hexdigest(digest, CLIENT_SECRET, json) == request.headers["X-Hub-Signature"]
  end
end
