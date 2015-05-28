$secrets = JSON.parse(File.read("../secrets.json"))
class AuthController < ApplicationController
  skip_before_action :authenticate, only: [:login]

  def login
    username = params['user']['username']
    password = params['user']['password']

    payload = {:user_id => 1}

    # here JWT is encrypting our userid and storing it in token
    token = JWT.encode payload, $secrets['jwt']['secret'], 'HS512'

    # return encrypted token to angular app
    render json: {token: token}
  end

  def test
    authheader = request.headers['HTTP_AUTHORIZATION']
    if authheader && authheader[0..6] == "Bearer "
      token = authheader[7..-1]
      decoded = JWT.decode token, $secrets['jwt']['secret']
      currentUserId = decoded[0]['user_id'];
      render json: {authorized: true}
    else
      render json: {authorized: false}
    end
  end
end