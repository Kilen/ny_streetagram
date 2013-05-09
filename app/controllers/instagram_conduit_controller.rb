class InstagramConduitController < ApplicationController
  def feed_reciver
    media = Media.create!(receives: params.to_json)
    render text: "Thank you"
  end

  def show_receives
    @receives = JSON.parse(Media.last.receives || { result: "no params" }.to_json)
  end

  def handle_instagram_validation
    render text: params["hub.challenge"] || "success"
  end
end
