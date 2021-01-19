Rails.application.routes.draw do

  post '/submit-pledge' => 'challenge#submit_pledge'
  post '/redeem-challenge' => 'challenge#redeem'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
