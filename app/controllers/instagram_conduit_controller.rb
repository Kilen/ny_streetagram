class InstagramConduitController < ApplicationController
  def feed_reciver
    data = ActiveSupport::JSON.decode request.body
    media = Media.create!(receives: data.to_json)
    render text: "Thank you"
  end

  def show_receives
    media = Media.last
    @receives = media.nil? ? { result: "no params" } : JSON.parse(media.receives) 
  end

  def handle_instagram_validation
    render text: params["hub.challenge"] || "success"
  end
end
