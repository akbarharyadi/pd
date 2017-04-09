require 'test_helper'

class PendataansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pendataan = pendataans(:one)
  end

  test "should get index" do
    get pendataans_url
    assert_response :success
  end

  test "should get new" do
    get new_pendataan_url
    assert_response :success
  end

  test "should create pendataan" do
    assert_difference('Pendataan.count') do
      post pendataans_url, params: { pendataan: { jumlah_pajak: @pendataan.jumlah_pajak, omzet: @pendataan.omzet, pendaftaran_id: @pendataan.pendaftaran_id, periode_akhir: @pendataan.periode_akhir, periode_awal: @pendataan.periode_awal, rekening_id: @pendataan.rekening_id, tahun_spt: @pendataan.tahun_spt, tgl_daftar: @pendataan.tgl_daftar } }
    end

    assert_redirected_to pendataan_url(Pendataan.last)
  end

  test "should show pendataan" do
    get pendataan_url(@pendataan)
    assert_response :success
  end

  test "should get edit" do
    get edit_pendataan_url(@pendataan)
    assert_response :success
  end

  test "should update pendataan" do
    patch pendataan_url(@pendataan), params: { pendataan: { jumlah_pajak: @pendataan.jumlah_pajak, omzet: @pendataan.omzet, pendaftaran_id: @pendataan.pendaftaran_id, periode_akhir: @pendataan.periode_akhir, periode_awal: @pendataan.periode_awal, rekening_id: @pendataan.rekening_id, tahun_spt: @pendataan.tahun_spt, tgl_daftar: @pendataan.tgl_daftar } }
    assert_redirected_to pendataan_url(@pendataan)
  end

  test "should destroy pendataan" do
    assert_difference('Pendataan.count', -1) do
      delete pendataan_url(@pendataan)
    end

    assert_redirected_to pendataans_url
  end
end
