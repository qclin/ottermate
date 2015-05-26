require 'test_helper'

class RoomReviewsControllerTest < ActionController::TestCase
  setup do
    @room_review = room_reviews(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:room_reviews)
  end

  test "should create room_review" do
    assert_difference('RoomReview.count') do
      post :create, room_review: { review: @room_review.review, reviewer_id: @room_review.reviewer_id, room_id: @room_review.room_id }
    end

    assert_response 201
  end

  test "should show room_review" do
    get :show, id: @room_review
    assert_response :success
  end

  test "should update room_review" do
    put :update, id: @room_review, room_review: { review: @room_review.review, reviewer_id: @room_review.reviewer_id, room_id: @room_review.room_id }
    assert_response 204
  end

  test "should destroy room_review" do
    assert_difference('RoomReview.count', -1) do
      delete :destroy, id: @room_review
    end

    assert_response 204
  end
end
