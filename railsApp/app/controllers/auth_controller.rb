$secrets = JSON.parse(File.read("../secrets.json"))
class AuthController < ApplicationController
  skip_before_action :authenticate, only: [:login]

  def login
    username = params['user']['username']
    password = params['user']['password']

    @user = User.find_by(username: username)

    if @user && @user.authenticate(password)
      # return encrypted token to angular app
      render json: {token: makeToken(@user.id)}
    else
      render json: {'authorized':'false'}, :status => 401
    end
  end

  # def test
  #   authheader = request.headers['HTTP_AUTHORIZATION']
  #   if authheader && authheader[0..6] == "Bearer "
  #     token = authheader[7..-1]
  #     decoded = JWT.decode token, $secrets['jwt']['secret']
  #     currentUserId = decoded[0]['user_id'];
  #     render json: {authorized: true}
  #   else
  #     render json: {authorized: false}
  #   end
  # end
end