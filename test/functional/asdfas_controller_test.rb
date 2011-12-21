require 'test_helper'

class AsdfasControllerTest < ActionController::TestCase
  setup do
    @asdfa = asdfas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:asdfas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create asdfa" do
    assert_difference('Asdfa.count') do
      post :create, :asdfa => @asdfa.attributes
    end

    assert_redirected_to asdfa_path(assigns(:asdfa))
  end

  test "should show asdfa" do
    get :show, :id => @asdfa.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @asdfa.to_param
    assert_response :success
  end

  test "should update asdfa" do
    put :update, :id => @asdfa.to_param, :asdfa => @asdfa.attributes
    assert_redirected_to asdfa_path(assigns(:asdfa))
  end

  test "should destroy asdfa" do
    assert_difference('Asdfa.count', -1) do
      delete :destroy, :id => @asdfa.to_param
    end

    assert_redirected_to asdfas_path
  end
end
