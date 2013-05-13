NYStreetagram::Application.routes.draw do

  root to: "instagram_conduit#show_photos_in_map"
  get "/index" => "instagram_conduit#show_photos_in_map"
  post "/callback" => "instagram_conduit#feed_receiver"
  get "/callback" => "instagram_conduit#handle_instagram_validation"
  get "/show_receives" => "instagram_conduit#show_receives"
  get "/fetch_new_photos" => "instagram_conduit#new_photos"

end
