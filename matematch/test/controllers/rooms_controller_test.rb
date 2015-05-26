require 'test_helper'

class RoomsControllerTest < ActionController::TestCase
  setup do
    @room = rooms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rooms)
  end

  test "should create room" do
    assert_difference('Room.count') do
      post :create, room: { description: @room.description, neighborhood: @room.neighborhood, petfriendly: @room.petfriendly, photo_url: @room.photo_url, price: @room.price }
    end

    assert_response 201
  end

  test "should show room" do
    get :show, id: @room
    assert_response :success
  end

  test "should update room" do
    put :update, id: @room, room: { description: @room.description, neighborhood: @room.neighborhood, petfriendly: @room.petfriendly, photo_url: @room.photo_url, price: @room.price }
    assert_response 204
  end

  test "should destroy room" do
    assert_difference('Room.count', -1) do
      delete :destroy, id: @room
    end

    assert_response 204
  end
end
