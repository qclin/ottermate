class CurrentUsersController < ApplicationController
  def show
    cid = currentUserId
    binding.pry
    render plain: "hi"
  end
end