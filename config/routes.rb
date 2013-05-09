NYStreetagram::Application.routes.draw do

  post "/callback" => "instagram_conduit#feed_reciver"
  get "/callback" => "instagram_conduit#handle_instagram_validation"
  get "/show_receives" => "instagram_conduit#show_receives"

end
