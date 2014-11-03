require 'test_helper'

class StartpointsControllerTest < ActionController::TestCase
  setup do
    @startpoint = startpoints(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:startpoints)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create startpoint" do
    assert_difference('Startpoint.count') do
      post :create, startpoint: { address_id: @startpoint.address_id }
    end

    assert_redirected_to startpoint_path(assigns(:startpoint))
  end

  test "should show startpoint" do
    get :show, id: @startpoint
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @startpoint
    assert_response :success
  end

  test "should update startpoint" do
    patch :update, id: @startpoint, startpoint: { address_id: @startpoint.address_id }
    assert_redirected_to startpoint_path(assigns(:startpoint))
  end

  test "should destroy startpoint" do
    assert_difference('Startpoint.count', -1) do
      delete :destroy, id: @startpoint
    end

    assert_redirected_to startpoints_path
  end
end
