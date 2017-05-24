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

  $(document).on 'change', '#pendataan_tahun_spt, #status_rekening', (evt) ->
    $.ajax '/rekenings/update_rekening',
      type: 'GET'
      dataType: 'json'
      data: {
        tahun_rekening: $("#pendataan_tahun_spt").val(),
        kode: $("#pendataan_kode_rekening").val(),
        status: $("#status_rekening").val(),
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
    if persen == 'null' or persen == '' 
       persen = '0'
    if tarif == 'null' or tarif == '' 
       tarif = '0'
    $('#pendataan_tarif_persen').val(Math.round(persen*100)/100);
    $('#pendataan_tarif_rupiah').autoNumeric('set', tarif);
    $('#pendataan_pemakaian_daya').trigger("change");
    $('#pendataan_volume_pemakaian').trigger("change");
    $('#pendataan_omzet').trigger("change");
    $('#pendataan_jumlah_volume').trigger("change");
    $('#pendataan_panjang_reklame').trigger("change");

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
    console.log(pemakaian)
    console.log(volume)
    console.log(persen)
    console.log(rupiah)
    if pemakaian == ''
      pemakaian = 1
    if volume == ''
      volume = 1
    if persen == ''
      persen = 0
    if rupiah == '' or rupiah == '0.00'
      rupiah = 1
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
  
  $(document).on 'change', '#pendataan_panjang_reklame, 
                              #pendataan_lebar_reklame, 
                                #pendataan_jumlah_reklame, 
                                  #pendataan_nilai_lokasi_reklame,
                                    #pendataan_jumlah_hari_reklame,
                                      #pendataan_sudut_pandang_reklame,
                                        #pendataan_tinggi_reklame', (evt) ->

    panjang = if $('#pendataan_panjang_reklame').val() == '' or $('#pendataan_panjang_reklame').val() == null then 0 else parseFloat($('#pendataan_panjang_reklame').val().replace(/\./g, '').replace(/\,/g, '.'))
    lebar = if $('#pendataan_lebar_reklame').val() == '' or $('#pendataan_lebar_reklame').val() == null then 0 else parseFloat($('#pendataan_lebar_reklame').val().replace(/\./g, '').replace(/\,/g, '.'))
    nilai_media = if $('#pendataan_tarif_rupiah').val() == '' or $('#pendataan_tarif_rupiah').val() == null then 0 else parseFloat($('#pendataan_tarif_rupiah').val().replace(/\./g, '').replace(/\,/g, '.'))
    tinggi = if $('#pendataan_tinggi_reklame').val() == '' or $('#pendataan_tinggi_reklame').val() == null then 0 else parseFloat($('#pendataan_tinggi_reklame').val().replace(/\./g, '').replace(/\,/g, '.'))
    skor_lokasi = if $('#pendataan_nilai_lokasi_reklame').val() == '' or $('#pendataan_nilai_lokasi_reklame').val() == null then 0 else parseFloat($('#pendataan_nilai_lokasi_reklame').val())
    skor_sudut_pandang = if $('#pendataan_sudut_pandang_reklame').val() == '' or $('#pendataan_sudut_pandang_reklame').val() == null then 0 else parseFloat($('#pendataan_sudut_pandang_reklame').val())
    skor_ketinggian = hitung_ketinggian(tinggi)
    tarifpr = if $('#pendataan_tarif_persen').val() == '' or $('#pendataan_tarif_persen').val() == null then 0 else parseFloat($('#pendataan_tarif_persen').val().replace(/\,/g, '.'))
    hari = if $('#pendataan_jumlah_hari_reklame').val() == '' or $('#pendataan_jumlah_hari_reklame').val() == null then 0 else parseFloat($('#pendataan_jumlah_hari_reklame').val())
    jumlah_reklame = if $('#pendataan_jumlah_reklame').val() == '' or $('#pendataan_jumlah_reklame').val() == null then 0 else parseFloat($('#pendataan_jumlah_reklame').val())
    luas = (panjang * lebar);
    pajak_reklame = 0
    total_nilai_strategis = 0
    total_media_reklame = 0
    nilai_sewa_reklame = 0

    $('#pendataan_luas_reklame').autoNumeric 'set', luas

    if $('#status_rekening').val() == 'tetap'
      #nilai sewa reklame
      nilai_luas_media_reklame = luas * nilai_media
      nilai_ketinggian = 100000 * tinggi
      total_nilai_media_reklame = nilai_luas + nilai_ketinggian

      jml_skor_lokasi = skor_lokasi * 50 / 100
      jml_skor_sudut_pandang = skor_sudut_pandang * 20 / 100
      jml_skor_ketinggian = skor_ketinggian * 30 / 100
      total_nilai_strategis = (jml_skor_lokasi + jml_skor_sudut_pandang + jml_skor_ketinggian) * tentukan_satuan_nilai_stategis(luas) * hari;
      nilai_sewa_reklame = total_nilai_media_reklame + total_nilai_strategis;
      pajak_reklame = tarifpr / 100 * nilai_sewa_reklame;
      total_media_reklame = total_nilai_media_reklame;
     else if $('#status_rekening').val() == 'isidentil'
      total_media_reklame = nilai_media * hari * luas
      total_nilai_strategis = skor_lokasi * 1000 * hari * luas
      pajak_reklame = tarifpr / 100 * (total_media_reklame + total_nilai_strategis)
      nilai_sewa_reklame = total_media_reklame + total_nilai_strategis

    console.log(total_nilai_strategis)
    if `typeof total_nilai_strategis == 'undefined'` or isNaN(total_nilai_strategis)
      `total_nilai_strategis = 0`
    $('#nilai_sewa_reklame').autoNumeric 'set', parseFloat(total_nilai_strategis)

    console.log(nilai_sewa_reklame)
    if `typeof nilai_sewa_reklame == 'undefined'` or isNaN(nilai_sewa_reklame)
      `nilai_sewa_reklame = 0`
    $('#nilai_sewa').autoNumeric 'set', parseFloat(nilai_sewa_reklame)
    console.log(total_media_reklame)
    if `typeof total_media_reklame == 'undefined'` or isNaN(total_media_reklame)
      `total_media_reklame = 0`
    $('#nilai_media').autoNumeric 'set', parseFloat(total_media_reklame)
    `pajak_jml_reklame = pajak_reklame * jumlah_reklame`
    if `typeof pajak_jml_reklame == 'undefined'` or isNaN(pajak_jml_reklame)
      `pajak_jml_reklame = 0`
    $('#pendataan_jumlah_pajak').autoNumeric 'set', parseFloat(pajak_jml_reklame)
  
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
  
  # change value using function padstring
  $(document).on 'change', '#no_pendaftaran, #no_pendaftaran2, #no_pendataan_penetapan', (evt) ->
    $(this).val(padstring('0000000', $(this).val()))
  
  # field only allow number
  $(document).on 'keypress', '.only_allow_number', (evt) -> 
    return evt.charCode >= 48 and evt.charCode <= 57

  $(document).on 'change', '#rokok', (evn) ->
    if this.checked
      $('#tarif_sebelum_rokok').val($('#pendataan_tarif_persen').val())
      $('#pendataan_tarif_persen, #pendataan_pajak_rokok').val('25')
      $('#pendataan_pajak_rokok').removeAttr('readonly')
    else
      $('#pendataan_tarif_persen').val($('#tarif_sebelum_rokok').val())
      $('#pendataan_pajak_rokok').attr('readonly','readonly')
  
  $(document).on 'change', '#pendataan_pajak_rokok', (evn) ->
    $('#pendataan_tarif_persen').val($('#pendataan_pajak_rokok').val())
    $("#pendataan_panjang_reklame").trigger("change");

  # padding string with zero leading
  window.padstring = (pad, str) ->
    return pad.substring(0, pad.length - str.length) + str
  
  # hitung ketinggian
  window.hitung_ketinggian = (i) ->
    x = 0
    if parseFloat(i) > 15
      x = 10
    else if parseFloat(i) >= 10 and parseFloat(i) <= 14.99
      x = 8
    else if parseFloat(i) >= 6 and parseFloat(i) <= 9.99
      x = 6
    else if parseFloat(i) >= 3 and parseFloat(i) <= 5.99
      x = 4
    else if parseFloat(i) <= 2.99
      x = 2
    x

  window.tentukan_satuan_nilai_stategis = (l) ->
    nilai_strategis = 0
    if parseFloat(l) >= 0.25 and parseFloat(l) <= 6.99
      nilai_strategis = 250000
    else if parseFloat(l) >= 7 and parseFloat(l) <= 15.99
      nilai_strategis = 500000
    else if parseFloat(l) >= 16 and parseFloat(l) <= 29.99
      nilai_strategis = 750000
    else if parseFloat(l) >= 30 and parseFloat(l) <= 40
      nilai_strategis = 1000000
    else if parseFloat(l) > 40
      nilai_strategis = 1750000
    nilai_strategis
  
  $('#pendataan_panjang_reklame').trigger("change");