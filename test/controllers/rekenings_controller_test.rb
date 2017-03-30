require 'test_helper'

class RekeningsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rekening = rekenings(:one)
  end

  test "should get index" do
    get rekenings_url
    assert_response :success
  end

  test "should get new" do
    get new_rekening_url
    assert_response :success
  end

  test "should create rekening" do
    assert_difference('Rekening.count') do
      post rekenings_url, params: { rekening: { jenis_kode: @rekening.jenis_kode, kode: @rekening.kode, persen: @rekening.persen, tahun: @rekening.tahun, tarif: @rekening.tarif, turunan_kode: @rekening.turunan_kode } }
    end

    assert_redirected_to rekening_url(Rekening.last)
  end

  test "should show rekening" do
    get rekening_url(@rekening)
    assert_response :success
  end

  test "should get edit" do
    get edit_rekening_url(@rekening)
    assert_response :success
  end

  test "should update rekening" do
    patch rekening_url(@rekening), params: { rekening: { jenis_kode: @rekening.jenis_kode, kode: @rekening.kode, persen: @rekening.persen, tahun: @rekening.tahun, tarif: @rekening.tarif, turunan_kode: @rekening.turunan_kode } }
    assert_redirected_to rekening_url(@rekening)
  end

  test "should destroy rekening" do
    assert_difference('Rekening.count', -1) do
      delete rekening_url(@rekening)
    end

    assert_redirected_to rekenings_url
  end
end
