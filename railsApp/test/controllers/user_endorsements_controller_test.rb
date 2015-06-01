require 'test_helper'

class UserEndorsementsControllerTest < ActionController::TestCase
  setup do
    @user_endorsement = user_endorsements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_endorsements)
  end

  test "should create user_endorsement" do
    assert_difference('UserEndorsement.count') do
      post :create, user_endorsement: { endorsee_id: @user_endorsement.endorsee_id, endorser_id: @user_endorsement.endorser_id, skill: @user_endorsement.skill }
    end

    assert_response 201
  end

  test "should show user_endorsement" do
    get :show, id: @user_endorsement
    assert_response :success
  end

  test "should update user_endorsement" do
    put :update, id: @user_endorsement, user_endorsement: { endorsee_id: @user_endorsement.endorsee_id, endorser_id: @user_endorsement.endorser_id, skill: @user_endorsement.skill }
    assert_response 204
  end

  test "should destroy user_endorsement" do
    assert_difference('UserEndorsement.count', -1) do
      delete :destroy, id: @user_endorsement
    end

    assert_response 204
  end
end
