require 'test_helper'

class OutboundsControllerTest < ActionController::TestCase
  setup do
    @outbound = outbounds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outbounds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outbound" do
    assert_difference('Outbound.count') do
      post :create, outbound: { user_id: @outbound.user_id }
    end

    assert_redirected_to outbound_path(assigns(:outbound))
  end

  test "should show outbound" do
    get :show, id: @outbound
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @outbound
    assert_response :success
  end

  test "should update outbound" do
    put :update, id: @outbound, outbound: { user_id: @outbound.user_id }
    assert_redirected_to outbound_path(assigns(:outbound))
  end

  test "should destroy outbound" do
    assert_difference('Outbound.count', -1) do
      delete :destroy, id: @outbound
    end

    assert_redirected_to outbounds_path
  end
end
