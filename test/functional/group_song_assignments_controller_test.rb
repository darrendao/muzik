require 'test_helper'

class GroupSongAssignmentsControllerTest < ActionController::TestCase
  setup do
    @group_song_assignment = group_song_assignments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_song_assignments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_song_assignment" do
    assert_difference('GroupSongAssignment.count') do
      post :create, :group_song_assignment => @group_song_assignment.attributes
    end

    assert_redirected_to group_song_assignment_path(assigns(:group_song_assignment))
  end

  test "should show group_song_assignment" do
    get :show, :id => @group_song_assignment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @group_song_assignment.to_param
    assert_response :success
  end

  test "should update group_song_assignment" do
    put :update, :id => @group_song_assignment.to_param, :group_song_assignment => @group_song_assignment.attributes
    assert_redirected_to group_song_assignment_path(assigns(:group_song_assignment))
  end

  test "should destroy group_song_assignment" do
    assert_difference('GroupSongAssignment.count', -1) do
      delete :destroy, :id => @group_song_assignment.to_param
    end

    assert_redirected_to group_song_assignments_path
  end
end
