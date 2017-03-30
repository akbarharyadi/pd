require 'test_helper'

class PendaftaransControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pendaftaran = pendaftarans(:one)
  end

  test "should get index" do
    get pendaftarans_url
    assert_response :success
  end

  test "should get new" do
    get new_pendaftaran_url
    assert_response :success
  end

  test "should create pendaftaran" do
    assert_difference('Pendaftaran.count') do
      post pendaftarans_url, params: { pendaftaran: { alamat_pemilik: @pendaftaran.alamat_pemilik, alamat_usaha: @pendaftaran.alamat_usaha, kecamatan_id: @pendaftaran.kecamatan_id, kelurahan_id: @pendaftaran.kelurahan_id, nama_pemilik: @pendaftaran.nama_pemilik, nama_usaha: @pendaftaran.nama_usaha, no_pendaftaran: @pendaftaran.no_pendaftaran, no_telp_pemilik: @pendaftaran.no_telp_pemilik, no_telp_usaha: @pendaftaran.no_telp_usaha, npwpd: @pendaftaran.npwpd, tgl_npwpd: @pendaftaran.tgl_npwpd, usaha_id: @pendaftaran.usaha_id } }
    end

    assert_redirected_to pendaftaran_url(Pendaftaran.last)
  end

  test "should show pendaftaran" do
    get pendaftaran_url(@pendaftaran)
    assert_response :success
  end

  test "should get edit" do
    get edit_pendaftaran_url(@pendaftaran)
    assert_response :success
  end

  test "should update pendaftaran" do
    patch pendaftaran_url(@pendaftaran), params: { pendaftaran: { alamat_pemilik: @pendaftaran.alamat_pemilik, alamat_usaha: @pendaftaran.alamat_usaha, kecamatan_id: @pendaftaran.kecamatan_id, kelurahan_id: @pendaftaran.kelurahan_id, nama_pemilik: @pendaftaran.nama_pemilik, nama_usaha: @pendaftaran.nama_usaha, no_pendaftaran: @pendaftaran.no_pendaftaran, no_telp_pemilik: @pendaftaran.no_telp_pemilik, no_telp_usaha: @pendaftaran.no_telp_usaha, npwpd: @pendaftaran.npwpd, tgl_npwpd: @pendaftaran.tgl_npwpd, usaha_id: @pendaftaran.usaha_id } }
    assert_redirected_to pendaftaran_url(@pendaftaran)
  end

  test "should destroy pendaftaran" do
    assert_difference('Pendaftaran.count', -1) do
      delete pendaftaran_url(@pendaftaran)
    end

    assert_redirected_to pendaftarans_url
  end
end
