# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # Inisialisasi field autonumeric
  $('input[data-role=money]').autoNumeric('init', {
        digitGroupSeparator        : '.',
        decimalCharacter           : ',',
        roundingMethod             : 'U',
    });
  
  # Dapatkan kelurahan berdasartkan kecamatan
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

   # copy no_telp usaha ke no_telp pelilik di pendaftaran
  $(document).on 'keyup', '#pendaftaran_no_telp_usaha', (evt) ->
    $('#pendaftaran_no_telp_pemilik').val($(this).val())

  $(document).on 'change', '#pendaftaran_kelurahan_id', (evt) ->
    $('#pendaftaran_npwpd').val($('#pajak').val() + '.' + $('#golongan').val() + '.' + $('#pendaftaran_no_pendaftaran').val() + '.' + $("#pendaftaran_kecamatan_id option:selected").text().substring(0, 3).trim() + '.' + $("#pendaftaran_kelurahan_id option:selected").text().substring(0,3).trim())

  $(document).on 'change', '#golongan', (evt) ->
    $('#pendaftaran_npwpd').val($('#pajak').val() + '.' + $('#golongan').val() + '.' + $('#pendaftaran_no_pendaftaran').val() + '.' + $("#pendaftaran_kecamatan_id option:selected").text().substring(0, 3).trim() + '.' + $("#pendaftaran_kelurahan_id option:selected").text().substring(0,3).trim())
  
  $(document).on 'change', '#filter_tahun_rekening', (evt) ->
    $.ajax '/rekenings/update_rekening',
      type: 'GET'
      dataType: 'json'
      data: {
        tahun_rekening: $("#filter_tahun_rekening option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        $("#filter_induk_rekening").html('')
        $("#filter_induk_rekening").append('<option value=""> -- Pilih induk Rekening -- </option>')
        for key, element of data
            $("#filter_induk_rekening").append('<option value="'+ element.kode+'">' + element.kode + ' - ' + element.nama_rekening + '</option>')
        $('.chosen-select').trigger('chosen:updated')
  
  $(document).on 'change', '#pendataan_periode_awal', (e) ->
     parts = $(this).val().split('-')
     now = new Date(parts[2], parts[1] - 1, parts[0])
     lastDayOfTheMonth = new Date()
     if $("#pendataan_kode_rekening").val() == '1104' or $("#pendataan_kode_rekening").val() == '1108'
      lastDayOfTheMonth = new Date(1900 + now.getYear() + 1, now.getMonth() + 1, 0)
     else
      lastDayOfTheMonth = new Date(1900 + now.getYear(), now.getMonth() + 1, 0)
     # $("#pendataan_periode_akhir").val(("0" + lastDayOfTheMonth.getDate()).slice(-2) + '-' + ("0" + (lastDayOfTheMonth.getMonth() + 1)).slice(-2) + '-' + (1900 + lastDayOfTheMonth.getYear()))
     if $(this).val() != ''
      $("#pendataan_periode_akhir").datepicker('setDate', lastDayOfTheMonth);
      $("#tgl_jth_tempo").val(("0" + (15)).slice(-2) + '-' + ("0" + (lastDayOfTheMonth.getMonth() + 2)).slice(-2) + '-' + (1900 + lastDayOfTheMonth.getYear()))

  $(document).on 'change', '#pendataan_tahun_spt', (evt) ->
    $.ajax '/rekenings/update_rekening',
      type: 'GET'
      dataType: 'json'
      data: {
        tahun_rekening: $("#pendataan_tahun_spt").val(),
        kode: $("#pendataan_kode_rekening").val(),
        turunan:true
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        $("#pendataan_rekening_id").html('')
        $("#pendataan_rekening_id").append('<option "> -- Pilih Rekening -- </option>')
        for key, element of data
            $("#pendataan_rekening_id").append('<option tarif="' + element.tarif + '" persen="' + element.persen + '" value="'+ element.id+'">4.' + element.kode + '.' + element.jenis_kode + '.' + element.turunan_kode + ' - ' + element.nama_rekening + '</option>')
        $('.chosen-select').trigger('chosen:updated')
    
  $(document).on 'change', '#pendataan_rekening_id', (evt, params) ->
    tarif = $('#pendataan_rekening_id option[value="' + params.selected + '"]').attr('tarif')
    persen = $('#pendataan_rekening_id option[value="' + params.selected + '"]').attr('persen')
    if persen == 'null' || persen == '' 
       persen = '0'
    if tarif == 'null' || tarif == '' 
       tarif = '0'
    $('#pendataan_tarif_persen').val(Math.round(persen*100)/100);
    $('#pendataan_tarif_rupiah').val(tarif);
    $('#pendataan_pemakaian_daya').val('')
    $('#pendataan_volume_pemakaian').val('')
    $('#pendataan_omzet').val('')
    $('#pendataan_jumlah_volume').val('')
    $('#pendataan_nilai_reklame').val('')

  $(document).on 'change', '#pendataan_omzet', (evt) ->
    omzet = $(this).val().replace(/\./g, '').replace(/\,/g, '.');
    persen = $('#pendataan_tarif_persen').val();
    if omzet == ''
      omzet = 0
    if persen == ''
      persen = 0
    $('#pendataan_jumlah_pajak').autoNumeric('set', omzet*(persen/100))
  
  $(document).on 'change', '#pendataan_pemakaian_daya, #pendataan_volume_pemakaian', (evt) ->
    pemakaian = $('#pendataan_pemakaian_daya').val().replace(/\./g, '').replace(/\,/g, '.');
    volume = $('#pendataan_volume_pemakaian').val().replace(/\./g, '').replace(/\,/g, '.');
    persen = $('#pendataan_tarif_persen').val();
    rupiah = $('#pendataan_tarif_rupiah').val().replace(/\./g, '').replace(/\,/g, '.');
    if pemakaian == ''
      pemakaian = 1
    if volume == ''
      volume = 1
    if persen == ''
      persen = 0
    if rupiah == ''
      rupiah = 0
    $('#pendataan_jumlah_pajak').autoNumeric('set', pemakaian*volume*rupiah*(persen/100))
  
  $(document).on 'change', '#pendataan_jumlah_volume', (evt) ->
    volume = $('#pendataan_jumlah_volume').val().replace(/\./g, '').replace(/\,/g, '.');
    persen = $('#pendataan_tarif_persen').val();
    rupiah = $('#pendataan_tarif_rupiah').val().replace(/\./g, '').replace(/\,/g, '.');
    if volume == ''
      volume = 1
    if persen == ''
      persen = 0
    if rupiah == ''
      rupiah = 0
    $('#pendataan_jumlah_pajak').autoNumeric('set', volume*rupiah*(persen/100))

  $(document).on 'change', '#pegawai_bidang_id', (evt) ->
    $.ajax '/seksis/update_seksi',
      type: 'GET'
      dataType: 'json'
      data: {
        bidang_id: $("#pegawai_bidang_id option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        $("#pegawai_seksi_id").html('')
        $("#pegawai_seksi_id").append('<option value=""> -- Pilih Seksi -- </option>')
        for key, element of data
            $("#pegawai_seksi_id").append('<option value="'+ element.id+'">' + element.kode_seksi + ' - ' + element.nama_seksi+ '</option>')
        $('.chosen-select').trigger('chosen:updated')
  
  $(document).on 'change', '#pendataan_nilai_reklame', (evt) ->
    nilai = $('#pendataan_nilai_reklame').val().replace(/\./g, '').replace(/\,/g, '.');
    persen = $('#pendataan_tarif_persen').val();
    rupiah = $('#pendataan_tarif_rupiah').val().replace(/\./g, '').replace(/\,/g, '.');
    if nilai == ''
      nilai = 1
    if persen == ''
      persen = 0
    if rupiah == ''
      rupiah = 0
    $('#pendataan_jumlah_pajak').autoNumeric('set', nilai*(persen/100))
  
  $(document).on 'change', '#pendataan_npa', (evt) ->
    nilai = $('#pendataan_npa').val().replace(/\./g, '').replace(/\,/g, '.');
    persen = $('#pendataan_tarif_persen').val();
    rupiah = $('#pendataan_tarif_rupiah').val().replace(/\./g, '').replace(/\,/g, '.');
    if nilai == ''
      nilai = 1
    if persen == ''
      persen = 0
    if rupiah == ''
      rupiah = 0
    $('#pendataan_jumlah_pajak').autoNumeric('set', nilai*(persen/100))
  
  $(document).on 'change', '#tanggal', (evt) ->
    $('#penetapan_tgl_tetap').val($(this).val())
    
  $(document).on 'change', '#no_pendataan_penetapan', (evt) ->
    $('#form-penetapan').submit();

  $(document).on 'change', '#penetapan_omzet_teliti', (evt) ->
    omzet = $(this).val().replace(/\./g, '').replace(/\,/g, '.');
    persen = $('#penetapan_tarif_persen_teliti').val();
    if omzet == ''
      omzet = 0
    if persen == ''
      persen = 0
    $('#penetapan_jumlah_pajak_teliti').autoNumeric('set', omzet*(persen/100))
    $("#penetapan_jumlah_pajak_teliti").trigger("change");
  
  $(document).on 'change', '#penetapan_pemakaian_daya_teliti, #penetapan_volume_pemakaian_teliti', (evt) ->
    pemakaian = $('#penetapan_pemakaian_daya_teliti').val().replace(/\./g, '').replace(/\,/g, '.');
    volume = $('#penetapan_volume_pemakaian_teliti').val().replace(/\./g, '').replace(/\,/g, '.');
    persen = $('#penetapan_tarif_persen_teliti').val();
    rupiah = $('#penetapan_tarif_rupiah_teliti').val().replace(/\./g, '').replace(/\,/g, '.');
    if pemakaian == ''
      pemakaian = 1
    if volume == ''
      volume = 1
    if persen == ''
      persen = 0
    if rupiah == ''
      rupiah = 0
    $('#penetapan_jumlah_pajak_teliti').autoNumeric('set', pemakaian*volume*rupiah*(persen/100))
    $("#penetapan_jumlah_pajak_teliti").trigger("change");
  
  $(document).on 'change', '#penetapan_jumlah_volume_teliti', (evt) ->
    volume = $('#penetapan_jumlah_volume_teliti').val().replace(/\./g, '').replace(/\,/g, '.');
    persen = $('#penetapan_tarif_persen_teliti').val();
    rupiah = $('#penetapan_tarif_rupiah_teliti').val().replace(/\./g, '').replace(/\,/g, '.');
    if volume == ''
      volume = 1
    if persen == ''
      persen = 0
    if rupiah == ''
      rupiah = 0
    $('#penetapan_jumlah_pajak_teliti').autoNumeric('set', volume*rupiah*(persen/100))
    $("#penetapan_jumlah_pajak_teliti").trigger("change");

  $(document).on 'change', '#penetapan_nilai_reklame_teliti', (evt) ->
    nilai = $('#penetapan_nilai_reklame_teliti').val().replace(/\./g, '').replace(/\,/g, '.');
    persen = $('#penetapan_tarif_persen_teliti').val();
    rupiah = $('#penetapan_tarif_rupiah_teliti').val().replace(/\./g, '').replace(/\,/g, '.');
    if nilai == ''
      nilai = 1
    if persen == ''
      persen = 0
    if rupiah == ''
      rupiah = 0
    $('#penetapan_jumlah_pajak_teliti').autoNumeric('set', nilai*(persen/100))
    $("#penetapan_jumlah_pajak_teliti").trigger("change");
  
  $(document).on 'change', '#penetapan_npa_teliti', (evt) ->
    nilai = $('#penetapan_npa_teliti').val().replace(/\./g, '').replace(/\,/g, '.');
    persen = $('#penetapan_tarif_persen_teliti').val();
    rupiah = $('#penetapan_tarif_rupiah_teliti').val().replace(/\./g, '').replace(/\,/g, '.');
    if nilai == ''
      nilai = 1
    if persen == ''
      persen = 0
    if rupiah == ''
      rupiah = 0
    $('#penetapan_jumlah_pajak_teliti').autoNumeric('set', nilai*(persen/100))
    $("#penetapan_jumlah_pajak_teliti").trigger("change");
  
  $(document).on 'change', '#penetapan_jumlah_pajak_teliti', (evt) ->
    # console.log($('#pendataan_jumlah_pajak').val())
    # console.log($(this).val())
    pendataan = $('#pendataan_jumlah_pajak').val().replace(/\./g, '').replace(/\,/g, '.')
    penelitian = $(this).val().replace(/\./g, '').replace(/\,/g, '.')
    selisih = parseFloat(penelitian) - parseFloat(pendataan)
    skp = 'SKPDKB'
    if selisih < 0
      selisih = 0
      skp = 'SKPDN'
    $('#selisih').autoNumeric('set', selisih)
    $('#hasil_penetapan').val(skp)

# padding string with zero leading
  window.padstring = (pad, str) ->
    return pad.substring(0, pad.length - str.length) + str