# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'change', '#pendaftaran_kecamatan_id', (evt) ->
    $.ajax '/kelurahans/update_kelurahan',
      type: 'GET'
      dataType: 'json'
      data: {
        kecamatan_id: $("#pendaftaran_kecamatan_id option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        $("#pendaftaran_kelurahan_id").html('')
        $("#pendaftaran_kelurahan_id").append('<option "> -- Pilih Kelurahan -- </option>')
        for key, element of data
            console.log(element.id)
            $("#pendaftaran_kelurahan_id").append('<option value="'+ element.id+'">' + element.kode + ' - ' + element.nama + '</option>')
        # $('.chosen-select').chosen allow_single_deselect: true
        $('#pendaftaran_npwpd').val($('#pajak').val() + '.' + $('#golongan').val() + '.' + $('#pendaftaran_no_pendaftaran').val() + '.' + $("#pendaftaran_kecamatan_id option:selected").text().substring(0, 3).trim() + '.' + $("#pendaftaran_kelurahan_id option:selected").text().substring(0,3).trim())
        $('.chosen-select').trigger('chosen:updated')

  $(document).on 'keyup', '#pendaftaran_no_telp_usaha', (evt) ->
    $('#pendaftaran_no_telp_pemilik').val($(this).val())

  $(document).on 'change', '#pendaftaran_kelurahan_id', (evt) ->
    $('#pendaftaran_npwpd').val($('#pajak').val() + '.' + $('#golongan').val() + '.' + $('#pendaftaran_no_pendaftaran').val() + '.' + $("#pendaftaran_kecamatan_id option:selected").text().substring(0, 3).trim() + '.' + $("#pendaftaran_kelurahan_id option:selected").text().substring(0,3).trim())

  $(document).on 'change', '#golongan', (evt) ->
    $('#pendaftaran_npwpd').val($('#pajak').val() + '.' + $('#golongan').val() + '.' + $('#pendaftaran_no_pendaftaran').val() + '.' + $("#pendaftaran_kecamatan_id option:selected").text().substring(0, 3).trim() + '.' + $("#pendaftaran_kelurahan_id option:selected").text().substring(0,3).trim())