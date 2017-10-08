Rails.application.routes.draw do

  # Pages
  get '/title_screen' => 'game#title_screen', as: :title_screen 
  get '/shutdown' => 'game#shutdown', as: :shutdown
  get '/loading_game' => 'game#loading_game', as: :loading_game
  get '/saving_game' => 'game#saving_game', as: :saving_game
  get '/world_map' => 'game#world_map', as: :world_map
  get '/battle' => 'game#battle', as: :battle
  get '/moviedex' => 'game#moviedex', as: :moviedex
  get '/moviedex_detail' => 'game#moviedex_detail', as: :moviedex_detail
  get '/lose' => 'game#lose', as: :lose
  get '/victory' => 'game#victory', as: :victory
  get '/coward' => 'game#coward', as: :coward
  root 'game#title_screen'

end
