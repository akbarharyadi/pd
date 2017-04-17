require 'test_helper'

class PegawaisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pegawai = pegawais(:one)
  end

  test "should get index" do
    get pegawais_url
    assert_response :success
  end

  test "should get new" do
    get new_pegawai_url
    assert_response :success
  end

  test "should create pegawai" do
    assert_difference('Pegawai.count') do
      post pegawais_url, params: { pegawai: { bidang_id: @pegawai.bidang_id, golongan_id: @pegawai.golongan_id, jabatan_id: @pegawai.jabatan_id, nama_pegawai: @pegawai.nama_pegawai, nip: @pegawai.nip, seksi_id: @pegawai.seksi_id } }
    end

    assert_redirected_to pegawai_url(Pegawai.last)
  end

  test "should show pegawai" do
    get pegawai_url(@pegawai)
    assert_response :success
  end

  test "should get edit" do
    get edit_pegawai_url(@pegawai)
    assert_response :success
  end

  test "should update pegawai" do
    patch pegawai_url(@pegawai), params: { pegawai: { bidang_id: @pegawai.bidang_id, golongan_id: @pegawai.golongan_id, jabatan_id: @pegawai.jabatan_id, nama_pegawai: @pegawai.nama_pegawai, nip: @pegawai.nip, seksi_id: @pegawai.seksi_id } }
    assert_redirected_to pegawai_url(@pegawai)
  end

  test "should destroy pegawai" do
    assert_difference('Pegawai.count', -1) do
      delete pegawai_url(@pegawai)
    end

    assert_redirected_to pegawais_url
  end
end
