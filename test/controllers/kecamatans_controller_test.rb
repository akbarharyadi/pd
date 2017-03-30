require 'test_helper'

class KecamatansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @kecamatan = kecamatans(:one)
  end

  test "should get index" do
    get kecamatans_url
    assert_response :success
  end

  test "should get new" do
    get new_kecamatan_url
    assert_response :success
  end

  test "should create kecamatan" do
    assert_difference('Kecamatan.count') do
      post kecamatans_url, params: { kecamatan: { kode: @kecamatan.kode, nama: @kecamatan.nama } }
    end

    assert_redirected_to kecamatan_url(Kecamatan.last)
  end

  test "should show kecamatan" do
    get kecamatan_url(@kecamatan)
    assert_response :success
  end

  test "should get edit" do
    get edit_kecamatan_url(@kecamatan)
    assert_response :success
  end

  test "should update kecamatan" do
    patch kecamatan_url(@kecamatan), params: { kecamatan: { kode: @kecamatan.kode, nama: @kecamatan.nama } }
    assert_redirected_to kecamatan_url(@kecamatan)
  end

  test "should destroy kecamatan" do
    assert_difference('Kecamatan.count', -1) do
      delete kecamatan_url(@kecamatan)
    end

    assert_redirected_to kecamatans_url
  end
end
