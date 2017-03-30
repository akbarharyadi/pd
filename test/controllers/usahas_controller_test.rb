require 'test_helper'

class UsahasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @usaha = usahas(:one)
  end

  test "should get index" do
    get usahas_url
    assert_response :success
  end

  test "should get new" do
    get new_usaha_url
    assert_response :success
  end

  test "should create usaha" do
    assert_difference('Usaha.count') do
      post usahas_url, params: { usaha: { kode_usaha: @usaha.kode_usaha, nama_usaha: @usaha.nama_usaha } }
    end

    assert_redirected_to usaha_url(Usaha.last)
  end

  test "should show usaha" do
    get usaha_url(@usaha)
    assert_response :success
  end

  test "should get edit" do
    get edit_usaha_url(@usaha)
    assert_response :success
  end

  test "should update usaha" do
    patch usaha_url(@usaha), params: { usaha: { kode_usaha: @usaha.kode_usaha, nama_usaha: @usaha.nama_usaha } }
    assert_redirected_to usaha_url(@usaha)
  end

  test "should destroy usaha" do
    assert_difference('Usaha.count', -1) do
      delete usaha_url(@usaha)
    end

    assert_redirected_to usahas_url
  end
end
