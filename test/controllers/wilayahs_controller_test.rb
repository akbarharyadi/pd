require 'test_helper'

class WilayahsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wilayah = wilayahs(:one)
  end

  test "should get index" do
    get wilayahs_url
    assert_response :success
  end

  test "should get new" do
    get new_wilayah_url
    assert_response :success
  end

  test "should create wilayah" do
    assert_difference('Wilayah.count') do
      post wilayahs_url, params: { wilayah: { alamat_badan: @wilayah.alamat_badan, ibu_kota: @wilayah.ibu_kota, jenis_wilayah: @wilayah.jenis_wilayah, nama_badan: @wilayah.nama_badan, nama_wilayah: @wilayah.nama_wilayah, pemimpin: @wilayah.pemimpin, telp_badan: @wilayah.telp_badan } }
    end

    assert_redirected_to wilayah_url(Wilayah.last)
  end

  test "should show wilayah" do
    get wilayah_url(@wilayah)
    assert_response :success
  end

  test "should get edit" do
    get edit_wilayah_url(@wilayah)
    assert_response :success
  end

  test "should update wilayah" do
    patch wilayah_url(@wilayah), params: { wilayah: { alamat_badan: @wilayah.alamat_badan, ibu_kota: @wilayah.ibu_kota, jenis_wilayah: @wilayah.jenis_wilayah, nama_badan: @wilayah.nama_badan, nama_wilayah: @wilayah.nama_wilayah, pemimpin: @wilayah.pemimpin, telp_badan: @wilayah.telp_badan } }
    assert_redirected_to wilayah_url(@wilayah)
  end

  test "should destroy wilayah" do
    assert_difference('Wilayah.count', -1) do
      delete wilayah_url(@wilayah)
    end

    assert_redirected_to wilayahs_url
  end
end
