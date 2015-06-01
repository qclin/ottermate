require 'test_helper'

class ChatsControllerTest < ActionController::TestCase
  setup do
    @chat = chats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chats)
  end

  test "should create chat" do
    assert_difference('Chat.count') do
      post :create, chat: { from_id: @chat.from_id, msg: @chat.msg, read: @chat.read, time: @chat.time, to_id: @chat.to_id }
    end

    assert_response 201
  end

  test "should show chat" do
    get :show, id: @chat
    assert_response :success
  end

  test "should update chat" do
    put :update, id: @chat, chat: { from_id: @chat.from_id, msg: @chat.msg, read: @chat.read, time: @chat.time, to_id: @chat.to_id }
    assert_response 204
  end

  test "should destroy chat" do
    assert_difference('Chat.count', -1) do
      delete :destroy, id: @chat
    end

    assert_response 204
  end
end
