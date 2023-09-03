require "test_helper"

class VonagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vonage = vonages(:one)
  end

  test "should get index" do
    get vonages_url
    assert_response :success
  end

  test "should get new" do
    get new_vonage_url
    assert_response :success
  end

  test "should create vonage" do
    assert_difference('Vonage.count') do
      post vonages_url, params: { vonage: {  } }
    end

    assert_redirected_to vonage_url(Vonage.last)
  end

  test "should show vonage" do
    get vonage_url(@vonage)
    assert_response :success
  end

  test "should get edit" do
    get edit_vonage_url(@vonage)
    assert_response :success
  end

  test "should update vonage" do
    patch vonage_url(@vonage), params: { vonage: {  } }
    assert_redirected_to vonage_url(@vonage)
  end

  test "should destroy vonage" do
    assert_difference('Vonage.count', -1) do
      delete vonage_url(@vonage)
    end

    assert_redirected_to vonages_url
  end
end
