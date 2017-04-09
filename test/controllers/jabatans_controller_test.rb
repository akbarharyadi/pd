require 'test_helper'

class JabatansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @jabatan = jabatans(:one)
  end

  test "should get index" do
    get jabatans_url
    assert_response :success
  end

  test "should get new" do
    get new_jabatan_url
    assert_response :success
  end

  test "should create jabatan" do
    assert_difference('Jabatan.count') do
      post jabatans_url, params: { jabatan: { kode_jabatan: @jabatan.kode_jabatan, nama_jabatan: @jabatan.nama_jabatan, singkatan: @jabatan.singkatan } }
    end

    assert_redirected_to jabatan_url(Jabatan.last)
  end

  test "should show jabatan" do
    get jabatan_url(@jabatan)
    assert_response :success
  end

  test "should get edit" do
    get edit_jabatan_url(@jabatan)
    assert_response :success
  end

  test "should update jabatan" do
    patch jabatan_url(@jabatan), params: { jabatan: { kode_jabatan: @jabatan.kode_jabatan, nama_jabatan: @jabatan.nama_jabatan, singkatan: @jabatan.singkatan } }
    assert_redirected_to jabatan_url(@jabatan)
  end

  test "should destroy jabatan" do
    assert_difference('Jabatan.count', -1) do
      delete jabatan_url(@jabatan)
    end

    assert_redirected_to jabatans_url
  end
end
