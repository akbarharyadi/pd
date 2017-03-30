require 'test_helper'

class KelurahansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @kelurahan = kelurahans(:one)
  end

  test "should get index" do
    get kelurahans_url
    assert_response :success
  end

  test "should get new" do
    get new_kelurahan_url
    assert_response :success
  end

  test "should create kelurahan" do
    assert_difference('Kelurahan.count') do
      post kelurahans_url, params: { kelurahan: { kode: @kelurahan.kode, nama: @kelurahan.nama } }
    end

    assert_redirected_to kelurahan_url(Kelurahan.last)
  end

  test "should show kelurahan" do
    get kelurahan_url(@kelurahan)
    assert_response :success
  end

  test "should get edit" do
    get edit_kelurahan_url(@kelurahan)
    assert_response :success
  end

  test "should update kelurahan" do
    patch kelurahan_url(@kelurahan), params: { kelurahan: { kode: @kelurahan.kode, nama: @kelurahan.nama } }
    assert_redirected_to kelurahan_url(@kelurahan)
  end

  test "should destroy kelurahan" do
    assert_difference('Kelurahan.count', -1) do
      delete kelurahan_url(@kelurahan)
    end

    assert_redirected_to kelurahans_url
  end
end
