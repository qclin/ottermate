$secrets = JSON.parse(File.read("../secrets.json"))
$exampletext = File.read("../exampletext.txt")

class WatsonController < ApplicationController
	def test
		# render plain: $exampletext
		res = HTTParty.post(
			$secrets['watson']['credentials']['url'],
			:body => $exampletext.to_json,
			:headers => { "Content-Type" => "application/json" },
			:user => $secrets['watson']['credentials']['username'],
			:password => $secrets['watson']['credentials']['password']
		)

		render plain: res.inspect


		 # + "api/v2/profile",
   #                        :body => data.to_json,
   #                        :headers => { "Content-Type" => "application/json" },
   #                        :user => settings.username,
   #                        :password => settings.password)
	end
end