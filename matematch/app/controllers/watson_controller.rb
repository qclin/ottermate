$secrets = JSON.parse(File.read("../secrets.json"))
$exampletext = File.read("../exampletext.txt")

class WatsonController < ApplicationController
	def test
		# render plain: $exampletext
		res = HTTParty.post("http://localhost:9090/analyzeme",
      :body => {:text => $exampletext}
		);

		render json: res.parsed_response
	end

  def show
    updateWatsonCache(currentUserId)
    updateWatsonCache(params[:id])

    user1 = User.find(currentUserId)
    user2 = User.find(params[:id])

    if user1.personality != nil && user2.personality != nil
      render json: {user1: {name: user1.username, personality: user1.personality},user2: {name: user2.username, personality: user2.personality}}
    else
      render json: {msg: 'not enough data'}, status: 404
    end
    # render json: {msg: 'hi'}
  end

  private
    def updateWatsonCache(user_id)
      user = User.find(user_id)
      if user.personality == nil && user.watsonfeed.scan(/\w+/).length >= 100
        res = HTTParty.post("http://localhost:9090/personality",
          :body => {:text => user.watsonfeed}
        );
        user.update({personality: res.parsed_response})
      end
    end
end