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
end