class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::Helpers
  include ActionController::Cookies
  include ActionController::ImplicitRender

  before_action :authenticate

  def setCurrentUserId(id)
    @currentUserId=id
  end
  def currentUserId
    @currentUserId
  end

  private
    def authenticate
      authheader = request.headers['HTTP_AUTHORIZATION']
      if authheader && authheader[0..6] == "Bearer "
        token = authheader[7..-1]
        decoded = JWT.decode token, $secrets['jwt']['secret']
        setCurrentUserId decoded[0]['user_id'];
      else
        render json: {'authorized':'false'}, :status => 401
      end

      # if !session[:user_id]
      #   redirect_to new_session_path
      # end
    end
end
