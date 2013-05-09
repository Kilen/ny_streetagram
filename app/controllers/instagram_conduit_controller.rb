class InstagramConduitController < ApplicationController
  def feed_reciver
    binding.pry
  end

  def handle_instagram_validation
    render text: params["hub.challenge"] || "success"
  end
end
