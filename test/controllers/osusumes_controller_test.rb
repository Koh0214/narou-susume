require 'test_helper'

class OsusumesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @osusume = osusumes(:one)
  end

  test "should get index" do
    get osusumes_url
    assert_response :success
  end

  test "should get new" do
    get new_osusume_url
    assert_response :success
  end

  test "should create osusume" do
    assert_difference('Osusume.count') do
      post osusumes_url, params: { osusume: { short-title: @osusume.short-title, title: @osusume.title } }
    end

    assert_redirected_to osusume_url(Osusume.last)
  end

  test "should show osusume" do
    get osusume_url(@osusume)
    assert_response :success
  end

  test "should get edit" do
    get edit_osusume_url(@osusume)
    assert_response :success
  end

  test "should update osusume" do
    patch osusume_url(@osusume), params: { osusume: { short-title: @osusume.short-title, title: @osusume.title } }
    assert_redirected_to osusume_url(@osusume)
  end

  test "should destroy osusume" do
    assert_difference('Osusume.count', -1) do
      delete osusume_url(@osusume)
    end

    assert_redirected_to osusumes_url
  end
end
