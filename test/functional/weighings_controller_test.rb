require 'test_helper'

class WeighingsControllerTest < ActionController::TestCase
  setup do
    @weighing = weighings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weighings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weighing" do
    assert_difference('Weighing.count') do
      post :create, :weighing => @weighing.attributes
    end

    assert_redirected_to weighing_path(assigns(:weighing))
  end

  test "should show weighing" do
    get :show, :id => @weighing.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @weighing.to_param
    assert_response :success
  end

  test "should update weighing" do
    put :update, :id => @weighing.to_param, :weighing => @weighing.attributes
    assert_redirected_to weighing_path(assigns(:weighing))
  end

  test "should destroy weighing" do
    assert_difference('Weighing.count', -1) do
      delete :destroy, :id => @weighing.to_param
    end

    assert_redirected_to weighings_path
  end
end
