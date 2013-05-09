NYStreetagram::Application.routes.draw do

  post "/callback" => "instagram_conduit#feed_reciver"
  get "/callback" => "instagram_conduit#handle_instagram_validation"

end
