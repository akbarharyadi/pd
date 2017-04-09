require 'test_helper'

class BidangsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bidang = bidangs(:one)
  end

  test "should get index" do
    get bidangs_url
    assert_response :success
  end

  test "should get new" do
    get new_bidang_url
    assert_response :success
  end

  test "should create bidang" do
    assert_difference('Bidang.count') do
      post bidangs_url, params: { bidang: { kode_bidang: @bidang.kode_bidang, nama_bidang: @bidang.nama_bidang } }
    end

    assert_redirected_to bidang_url(Bidang.last)
  end

  test "should show bidang" do
    get bidang_url(@bidang)
    assert_response :success
  end

  test "should get edit" do
    get edit_bidang_url(@bidang)
    assert_response :success
  end

  test "should update bidang" do
    patch bidang_url(@bidang), params: { bidang: { kode_bidang: @bidang.kode_bidang, nama_bidang: @bidang.nama_bidang } }
    assert_redirected_to bidang_url(@bidang)
  end

  test "should destroy bidang" do
    assert_difference('Bidang.count', -1) do
      delete bidang_url(@bidang)
    end

    assert_redirected_to bidangs_url
  end
end
