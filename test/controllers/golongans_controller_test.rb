require 'test_helper'

class GolongansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @golongan = golongans(:one)
  end

  test "should get index" do
    get golongans_url
    assert_response :success
  end

  test "should get new" do
    get new_golongan_url
    assert_response :success
  end

  test "should create golongan" do
    assert_difference('Golongan.count') do
      post golongans_url, params: { golongan: { golongan: @golongan.golongan, nama_pangkat: @golongan.nama_pangkat, ruang: @golongan.ruang } }
    end

    assert_redirected_to golongan_url(Golongan.last)
  end

  test "should show golongan" do
    get golongan_url(@golongan)
    assert_response :success
  end

  test "should get edit" do
    get edit_golongan_url(@golongan)
    assert_response :success
  end

  test "should update golongan" do
    patch golongan_url(@golongan), params: { golongan: { golongan: @golongan.golongan, nama_pangkat: @golongan.nama_pangkat, ruang: @golongan.ruang } }
    assert_redirected_to golongan_url(@golongan)
  end

  test "should destroy golongan" do
    assert_difference('Golongan.count', -1) do
      delete golongan_url(@golongan)
    end

    assert_redirected_to golongans_url
  end
end
