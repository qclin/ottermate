$secrets = JSON.parse(File.read("../secrets.json"))
class AuthController < ApplicationController
  skip_before_action :authenticate, only: [:login]

  def login
    username = params['user']['username']
    password = params['user']['password']

    user = User.find_by(name: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:username] = user.name
    else
      @name = params[:name]
      @error = "Unknown Username"
      render :new
    end

    # return encrypted token to angular app
    render json: {token: makeToken(1)}
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