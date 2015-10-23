Rails.application.routes.draw do
  root to: 'players#index'
  get 'players/by_name' => 'players#by_name'
  get 'players/:id/matches_played' => 'players#matches_played'
  resources 'players'
  get 'matches/recent' => 'matches#recent'
  resources 'matches'
end
