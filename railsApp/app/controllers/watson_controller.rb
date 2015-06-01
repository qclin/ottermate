$secrets = JSON.parse(File.read("../secrets.json"))

class WatsonController < ApplicationController
	def test
		# render plain: $exampletext
		res = HTTParty.post("http://localhost:9090/analyzeme",
      :body => {:text => $exampletext}
		);

		render json: res.parsed_response
	end

  def show
    binding.pry
    updateWatsonCache(currentUserId)
    updateWatsonCache(params[:id]) if params[:id] != "undefined"

    user1 = User.find(currentUserId)
    if params[:id] != "undefined"
      user2 = User.find(params[:id])
    else
      user2 = nil
    end
  
    if (user1 != nil && user1.personality != nil) || (user2 != nil && user2.personality != nil)
      output = {user1: {name: user1.username, personality: user1.personality}}
      if user2 == nil
        output[:user2] = nil
      else
        output[:user2] = {name: user2.username, personality: user2.personality}
      end
      render json: output
    else
      render json: {msg: 'not enough data'}, status: 404
    end
  end

  private
    def updateWatsonCache(user_id)
      user = User.find(user_id)
      if user != nil && user.personality == nil && user.watsonfeed != nil && user.watsonfeed.scan(/\w+/).length >= 100
        res = HTTParty.post("http://localhost:9090/personality",
          :body => {:text => user.watsonfeed}
        );
        user.update({personality: res.parsed_response.to_json})
      end
    end
end