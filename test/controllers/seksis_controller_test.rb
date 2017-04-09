require 'test_helper'

class SeksisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @seksi = seksis(:one)
  end

  test "should get index" do
    get seksis_url
    assert_response :success
  end

  test "should get new" do
    get new_seksi_url
    assert_response :success
  end

  test "should create seksi" do
    assert_difference('Seksi.count') do
      post seksis_url, params: { seksi: { bidang_id: @seksi.bidang_id, kode_seksi: @seksi.kode_seksi, nama_seksi: @seksi.nama_seksi, singkatan: @seksi.singkatan } }
    end

    assert_redirected_to seksi_url(Seksi.last)
  end

  test "should show seksi" do
    get seksi_url(@seksi)
    assert_response :success
  end

  test "should get edit" do
    get edit_seksi_url(@seksi)
    assert_response :success
  end

  test "should update seksi" do
    patch seksi_url(@seksi), params: { seksi: { bidang_id: @seksi.bidang_id, kode_seksi: @seksi.kode_seksi, nama_seksi: @seksi.nama_seksi, singkatan: @seksi.singkatan } }
    assert_redirected_to seksi_url(@seksi)
  end

  test "should destroy seksi" do
    assert_difference('Seksi.count', -1) do
      delete seksi_url(@seksi)
    end

    assert_redirected_to seksis_url
  end
end
