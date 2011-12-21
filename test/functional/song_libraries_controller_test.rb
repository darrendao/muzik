require 'test_helper'

class SongLibrariesControllerTest < ActionController::TestCase
  setup do
    @song_library = song_libraries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:song_libraries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create song_library" do
    assert_difference('SongLibrary.count') do
      post :create, :song_library => @song_library.attributes
    end

    assert_redirected_to song_library_path(assigns(:song_library))
  end

  test "should show song_library" do
    get :show, :id => @song_library.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @song_library.to_param
    assert_response :success
  end

  test "should update song_library" do
    put :update, :id => @song_library.to_param, :song_library => @song_library.attributes
    assert_redirected_to song_library_path(assigns(:song_library))
  end

  test "should destroy song_library" do
    assert_difference('SongLibrary.count', -1) do
      delete :destroy, :id => @song_library.to_param
    end

    assert_redirected_to song_libraries_path
  end
end
