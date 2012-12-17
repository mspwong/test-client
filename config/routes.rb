TestClient::Application.routes.draw do

  get 'test-hash', to: 'default#test_hash'

  get 'test-faraday', to: 'default#test_faraday'

end
