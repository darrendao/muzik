require 'test_helper'

class LocationGroupAssignmentsControllerTest < ActionController::TestCase
  setup do
    @location_group_assignment = location_group_assignments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:location_group_assignments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create location_group_assignment" do
    assert_difference('LocationGroupAssignment.count') do
      post :create, :location_group_assignment => @location_group_assignment.attributes
    end

    assert_redirected_to location_group_assignment_path(assigns(:location_group_assignment))
  end

  test "should show location_group_assignment" do
    get :show, :id => @location_group_assignment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @location_group_assignment.to_param
    assert_response :success
  end

  test "should update location_group_assignment" do
    put :update, :id => @location_group_assignment.to_param, :location_group_assignment => @location_group_assignment.attributes
    assert_redirected_to location_group_assignment_path(assigns(:location_group_assignment))
  end

  test "should destroy location_group_assignment" do
    assert_difference('LocationGroupAssignment.count', -1) do
      delete :destroy, :id => @location_group_assignment.to_param
    end

    assert_redirected_to location_group_assignments_path
  end
end
