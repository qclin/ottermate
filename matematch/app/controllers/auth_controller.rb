$secrets = JSON.parse(File.read("../secrets.json"))
class AuthController < ApplicationController
  def authenticate
    username = params['user']['username']
    password = params['user']['password']

    # user = User.find_by(username: username)
    payload = {:user_id => 1}
    token = JWT.encode payload, $secrets['jwt']['secret'], 'HS512'
    decoded = JWT.decode token, $secrets['jwt']['secret']
    render json: {token: token}
    # render json: {name: $secrets['jwt']['secret']}
  end

  def test
    authheader = request.headers['HTTP_AUTHORIZATION']
    if authheader[0..6] == "Bearer "
      token = authheader[7..-1]
      decoded = JWT.decode token, $secrets['jwt']['secret']
      
      binding.pry
    end
    render json: {headers: authheader}
  end
end