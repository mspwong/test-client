TestClient::Application.routes.draw do

  get 'via-net', to: 'default#post_hash_via_net'

  get 'via-faraday', to: 'default#post_hash_via_faraday'

end
