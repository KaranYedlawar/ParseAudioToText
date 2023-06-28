Rails.application.routes.draw do

  post '/translate', to: 'transcripts#translate'
end
