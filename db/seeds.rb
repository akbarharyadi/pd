# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or create!d alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)

user = User.new
user.email = 'admin@pajakdaerah.com'
user.password = 'password'
user.password_confirmation = 'password'
user.save!

Wilayah.create!(
    nama_wilayah:'Bengkayang',
    jenis_wilayah:'Kabupaten',
    pemimpin:'Bupati',
    nama_badan:'BADAN PENGELOLAAN KEUANGAN DAN ASET DAERAH',
    singkatan:'BPKAD',
    ibu_kota:'Bengkayang',
    telp_badan:'(0562)441808,441554,441553',
    fax:'(0562)441808,441057',
    alamat_badan:'Jalan Guna Trans Rangkang',
    kode_pos:'79282'
)

Kecamatan.create!([
    {kode:'01', nama:'Sungai Raya'},
    {kode:'02', nama:'Samalantan'},
    {kode:'03', nama:'Ledo'},
    {kode:'04', nama:'Bengkayang'},
    {kode:'05', nama:'Seluas'},
    {kode:'06', nama:'Sanggau Ledo'},
    {kode:'07', nama:'Jagoi Babang'},
    {kode:'08', nama:'Monterado'},
    {kode:'09', nama:'Teriak'},
    {kode:'10', nama:'Suti Semarang'},
    {kode:'11', nama:'Capkala'},
    {kode:'12', nama:'Siding'},
    {kode:'13', nama:'Lumar'},
    {kode:'14', nama:'Sungai Betung'},
    {kode:'15', nama:'Sungai Raya.Kepulauan'},
    {kode:'16', nama:'Lembah Bawang'},
    {kode:'17', nama:'Tujuh Belas'},
    {kode:'00', nama:'Luar Daerah'},
])

kelurahan_list = [
    ['01', '01', 'Sungai Duri'],
    ['01', '02', 'Sungai Jaga A'],
    ['01', '03', 'Sungai Jaga B'],
    ['01', '04', 'Sungai Pangkalan I'],
    ['01', '05', 'Sungai Pangkalan II'],

    ['02', '01', 'Samalantan'],
    ['02', '02', 'Saba`u'],
    ['02', '03', 'Tumiang'],
    ['02', '04', 'Babane'],
    ['02', '05', 'Pasti Jaya'],
    ['02', '06', 'Bukit Serayan'],
    ['02', '07', 'Marunsu'],

    ['03', '01', 'Lesabela'],
    ['03', '02', 'Semangat'],
    ['03', '03', 'Serangkat'],
    ['03', '04', 'Rodaya'],
    ['03', '05', 'Dayung'],
    ['03', '06', 'Jesape'],
    ['03', '07', 'Lomba Karya'],
    ['03', '08', 'Sidai'],
    ['03', '09', 'Seles'],
    ['03', '10', 'Tebuah Marong'],
    ['03', '11', 'Suka Damai'],
    ['03', '12', 'Suka Jaya'],

    ['04', '01', 'Kel. Bumi Emas'],
    ['04', '02', 'Tirta Kencana'],
    ['04', '03', 'Bani Amas'],
    ['04', '04', 'Bakti Mulya'],
    ['04', '05', 'Setia Budi'],
    ['04', '06', 'Kel. Sebalo'],

    ['05', '01', 'Seluas'],
    ['05', '02', 'Bengkawu'],
    ['05', '03', 'Sahan'],
    ['05', '04', 'Mayak'],
    ['05', '05', 'Kalon'],
    ['05', '06', 'Sentangu Jaya'],

    ['06', '01', 'Lembang'],
    ['06', '02', 'Gua'],
    ['06', '03', 'Bange'],
    ['06', '04', 'Danti'],
    ['06', '05', 'Sango'],

    ['07', '01', 'Jagoi'],
    ['07', '02', 'Kumba'],
    ['07', '03', 'Sekida'],
    ['07', '04', 'Gersik'],
    ['07', '05', 'Semunying Jaya'],
    ['07', '06', 'Sinar Baru'],

    ['08', '01', 'Siaga'],
    ['08', '02', 'Nek Ginap'],
    ['08', '03', 'Beringin Baru'],
    ['08', '04', 'Gerantung'],
    ['08', '05', 'Sendoreng'],
    ['08', '06', 'Rantau'],
    ['08', '07', 'Mekar Baru'],
    ['08', '08', 'Monterado'],
    ['08', '09', 'Jahandung'],
    ['08', '10', 'Goa Boma'],
    ['08', '11', 'Serindu'],

    ['09', '01', 'Dharma Bhakti'],
    ['09', '02', 'Sebetung Menyala'],
    ['09', '03', 'Malo Jelayan'],
    ['09', '04', 'Ampar Benteng'],
    ['09', '05', 'Tanjung'],
    ['09', '06', 'Telidik'],
    ['09', '07', 'Puteng'],
    ['09', '08', 'Sekaruh'],
    ['09', '09', 'Sumber Karya'],
    ['09', '10', 'Tubajur'],
    ['09', '11', 'Setia Jaya'],
    ['09', '12', 'Lulang'],
    ['09', '13', 'Bangun Sari'],
    ['09', '14', 'Benteng'],
    ['09', '15', 'Sebente'],
    ['09', '16', 'Teriak'],
    ['09', '17', 'Temia Sio'],
    ['09', '18', 'Bana'],

    ['10', '01', 'Nangka'],
    ['10', '02', 'Kiung'],
    ['10', '03', 'Muhi Bersatu'],
    ['10', '04', 'Suka Maju'],
    ['10', '05', 'Kelayu'],
    ['10', '06', 'Cempaka Putih'],
    ['10', '07', 'Suti Semarang'],
    ['10', '08', 'Tapen'],

    ['11', '01', 'Capkala'],
    ['11', '02', 'Setanduk'],
    ['11', '03', 'Aris'],
    ['11', '04', 'Mandor'],
    ['11', '05', 'Sebandut'],
    ['11', '06', 'Pawangi'],

    ['12', '01', 'Siding'],
    ['12', '02', 'Hli Buie'],
    ['12', '03', 'Tangguh'],
    ['12', '04', 'Tamong'],
    ['12', '05', 'Tawang'],
    ['12', '06', 'Sungkung I'],
    ['12', '07', 'Sungkung II'],
    ['12', '08', 'Sungkung III'],

    ['13', '01', 'Magmagan Karya'],
    ['13', '02', 'Tiga Berkat'],
    ['13', '03', 'Seren Selimbau'],
    ['13', '04', 'Belimbing'],
    ['13', '05', 'Lamolda'],

    ['14', '01', 'Cipta Karya'],
    ['14', '02', 'Suka Bangun'],
    ['14', '03', 'Karya Bhakti'],
    ['14', '04', 'Suka Maju'],

    ['15', '01', 'Karimunting'],
    ['15', '02', 'Rukma Jaya'],
    ['15', '03', 'Sungai Keran'],
    ['15', '04', 'Sungai Raya'],
    ['15', '05', 'Pulau Lemukutan'],

    ['16', '01', 'Godang Damar'],
    ['16', '02', 'Kinande'],
    ['16', '03', 'Tempapam'],
    ['16', '04', 'Papan Uduk'],
    ['16', '05', 'Papan Tembawang'],
    ['16', '06', 'Lembah Bawang'],
    ['16', '07', 'Saka Taru'],
    ['16', '08', 'Janyat'],

    ['17', '01', 'Bengkilu'],
    ['17', '02', 'Pisak'],
    ['17', '03', 'Kamuh'],
    ['17', '04', 'Sinar Tebudak'],

    ['00', '00', 'Luar Daerah'],
]

kelurahan_list.each do |n|
    Kelurahan.create!(kecamatan_id:Kecamatan.find_by_kode(n[0]).id, kode:n[1], nama:n[2])
end

pajak_list = [
    [3473, '1101', '00', '00', 'PAJAK HOTEL', nil, nil, nil, nil, 2017, nil, nil, 0, 0, 3009, 42, '2017-01-03 17:30:03', 42, '2017-01-03 17:30:03'],
    [3317, '1101', '01', '00', 'Hotel Bintang Lima', 0.1, nil, nil, nil, 2017, nil, nil, 0, 0, 3010, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3283, '1101', '02', '00', 'Hotel Bintang Empat', 0.1, nil, nil, nil, 2017, nil, nil, 0, 0, 3011, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3324, '1101', '03', '00', 'Hotel Bintang Tiga', 0.1, nil, nil, nil, 2017, nil, nil, 0, 0, 3001, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3284, '1101', '04', '00', 'Hotel Melati Tiga', 0.1, nil, nil, nil, 2017, nil, nil, 0, 0, 3012, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3285, '1101', '05', '00', 'Hotel Melati Dua', 0.1, nil, nil, nil, 2017, nil, nil, 0, 0, 3013, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3334, '1101', '06', '00', 'Hotel Melati Satu', 0.1, nil, nil, nil, 2017, nil, nil, 0, 0, 3014, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3412, '1101', '07', '00', 'Motel', 0.1, nil, nil, nil, 2017, nil, nil, 0, 0, 3015, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3444, '1101', '08', '00', 'Cottage', 0.1, nil, nil, nil, 2017, nil, nil, 0, 0, 3016, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3286, '1101', '09', '00', 'Losmen', 0.1, nil, nil, nil, 2017, nil, nil, 0, 0, 3017, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3286, '1101', '10', '00', 'Rumah Penginapan', 0.1, nil, nil, nil, 2017, nil, nil, 0, 0, 3017, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3286, '1101', '11', '00', 'Kost', 0.1, nil, nil, nil, 2017, nil, nil, 0, 0, 3017, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3445, '1101', '12', '00', 'Wisma Pariwisata', 0.1, nil, nil, nil, 2017, nil, nil, 0, 0, 3018, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3445, '1101', '13', '00', 'Gubuk Pariwisata', 0.1, nil, nil, nil, 2017, nil, nil, 0, 0, 3018, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    
    [3287, '1102', '00', '00', 'PAJAK RESTORAN', nil, nil, nil, nil, 2017, nil, nil, 0, 0, 3019, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3389, '1102', '01', '00', 'Restoran', 0.1, nil, nil, nil, 2017, nil, nil, 0, 0, 3020, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3397, '1102', '02', '00', 'Rumah Makan', 0.1, nil, nil, nil, 2017, nil, nil, 0, 0, 3021, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3288, '1102', '03', '00', 'Kafetaria', 0.1, nil, nil, nil, 2017, nil, nil, 0, 0, 3022, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3390, '1102', '04', '00', 'Kantin', 0.1, nil, nil, nil, 2017, nil, nil, 0, 0, 3023, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3458, '1102', '05', '00', 'Katering', 0.1, nil, nil, nil, 2017, nil, nil, 0, 0, 3024, 42, '2017-01-03 17:30:03', 42, '2017-01-03 17:30:03'],
    [3458, '1102', '06', '00', 'Warung', 0.1, nil, nil, nil, 2017, nil, nil, 0, 0, 3024, 42, '2017-01-03 17:30:03', 42, '2017-01-03 17:30:03'],
    [3458, '1102', '07', '00', 'Bar', 0.1, nil, nil, nil, 2017, nil, nil, 0, 0, 3024, 42, '2017-01-03 17:30:03', 42, '2017-01-03 17:30:03'],
    [3458, '1102', '08', '00', 'Jasa Boga', 0.1, nil, nil, nil, 2017, nil, nil, 0, 0, 3024, 42, '2017-01-03 17:30:03', 42, '2017-01-03 17:30:03'],
    
    [3413, '1103', '00', '00', 'PAJAK HIBURAN', nil, nil, nil, nil, 2017, nil, nil, 0, 0, 3025, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3289, '1103', '01', '00', 'Hiburan Biasa', 0.25, nil, nil, nil, 2017, nil, nil, 0, 0, 3026, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3290, '1103', '02', '00', 'Permainan Ketangkasan', 0.50, nil, nil, nil, 2017, nil, nil, 0, 0, 3027, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3303, '1103', '03', '00', 'DISKOTIK', 0.50, nil, nil, nil, 2017, nil, nil, 0, 0, 3029, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3304, '1103', '04', '00', 'Klab Malam', 0.50, nil, nil, nil, 2017, nil, nil, 0, 0, 3038, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3315, '1103', '05', '00', 'KARAOKE', 0.50, nil, nil, nil, 2017, nil, nil, 0, 0, 3039, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3318, '1103', '06', '00', 'Mandi Uap', 0.50, nil, nil, nil, 2017, nil, nil, 0, 0, 3032, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3391, '1103', '07', '00', 'Panti Pijat', 0.50, nil, nil, nil, 2017, nil, nil, 0, 0, 3028, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3392, '1103', '08', '00', 'Pegelaran busana', 0.50, nil, nil, nil, 2017, nil, nil, 0, 0, 3030, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3398, '1103', '09', '00', 'Kontes Kecantikan', 0.50, nil, nil, nil, 2017, nil, nil, 0, 0, 3035, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3415, '1103', '10', '00', 'Hiburan Kesenian Rakyat / Tradisional', 0.05, nil, nil, nil, 2017, nil, nil, 0, 0, 3036, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    
    [3733, '1104', '00', '00', 'PAJAK REKLAME', 0, nil, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', nil, nil, nil],
    [3749, '1104', '01', '01', 'REKLAME MEGATRON / VIDEOTRON / LED 0,25 - 9,99M2', 0.15, 1000000, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 1, nil, nil],
    [3743, '1104', '01', '02', 'REKLAME MEGATRON / VIDEOTRON / LED 10 - 24,99M2', 0.15, 1300000, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 1, nil, nil],
    [3604, '1104', '01', '03', 'REKLAME MEGATRON / VIDEOTRON / LED > 25M2', 0.15, 1750000, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 1, nil, nil],
    [3605, '1104', '02', '01', 'REKLAME BILLBOARD DENGAN PENERANGAN 10 - 24,99M2', 0.15, 350000, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 1, nil, nil],
    [3603, '1104', '02', '02', 'REKLAME BILLBOARD DENGAN PENERANGAN 0,25 - 9,99M2', 0.15, 450000, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 1, nil, nil],
    [3736, '1104', '02', '03', 'REKLAME BILLBOARD DENGAN PENERANGAN > 25M2', 0.15, 550000, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 1, nil, nil],
    [3737, '1104', '02', '04', 'REKLAME BILLBOARD TANPA PENERANGAN 0,25 - 9,99M2', 0.15, 200000, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 1, nil, nil],
    [3738, '1104', '02', '05', 'REKLAME BILLBOARD TANPA PENERANGAN 10 - 24,99M2', 0.15, 300000, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 1, nil, nil],
    [3739, '1104', '02', '06', 'REKLAME BILLBOARD TANPA PENERANGAN > 25M2', 0.15, 450000, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 1, nil, nil],
    [3745, '1104', '02', '07', 'REKLAME PAPAN DENGAN PENERANGAN 0,25 - 9,99M2', 0.15, 125000, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 1, nil, nil],
    [3740, '1104', '02', '08', 'REKLAME PAPAN DENGAN PENERANGAN 10 - 24,99M2', 0.15, 200000, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 1, nil, nil],
    [3734, '1104', '02', '09', 'REKLAME PAPAN DENGAN PENERANGAN > 25M2', 0.15, 300000, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 1, nil, nil],
    [3601, '1104', '02', '10', 'REKLAME PAPAN TANPA PENERANGAN 0,25 - 9,99M2', 0.15, 50000, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 1, nil, nil],
    [3602, '1104', '02', '11', 'REKLAME PAPAN TANPA PENERANGAN 10 - 24,99M2', 0.15, 125000, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 1, nil, nil],
    [3735, '1104', '02', '12', 'REKLAME PAPAN TANPA PENERANGAN > 25M2', 0.15, 200000, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 1, nil, nil],
    [3735, '1104', '03', '01', 'REKLAME BERJALAN / KENDARAAN 0,25 - 9,99M2', 0.15, 20000, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 1, nil, nil],
    [3735, '1104', '03', '02', 'REKLAME BERJALAN / KENDARAAN 10 - 24,99M2', 0.15, 35000, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 1, nil, nil],
    [3735, '1104', '03', '03', 'REKLAME BERJALAN / KENDARAAN  > 25M2', 0.15, 50000, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 1, nil, nil],
    [3750, '1104', '04', '01', 'REKLAME BALIHO', 0.20, 5000, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 2, 'HARI', nil],
    [3751, '1104', '05', '01', 'REKLAME KAIN / SPANDUK / UMBUL-UMBUL', 0.15, 5000, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 2, 'HARI', nil],
    [3753, '1104', '06', '01', 'REKLAME MELEKAT / STICKER', 0.10, 250, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 2, 'BULAN', nil],
    [3752, '1104', '07', '01', 'REKLAME SELEBARAN / BROSUR / LEAFLET', 0.15, 250, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 2, 'BULAN', nil],
    [3756, '1104', '08', '01', 'REKLAME FILM / SLIDE DENGAN SUARA', 0.20, 2500, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 2, 'PENYELENGG', nil],
    [3757, '1104', '08', '02', 'REKLAME FILM / SLIDE TANPA SUARA', 0.20, 1000, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 2, 'PENYELENGG', nil],
    [3754, '1104', '07', '01', 'REKLAME UDARA / BALON', 0.15, 300000, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 2, 'BULAN', nil],
    [3758, '1104', '09', '01', 'REKLAME PERAGAAN DILUAR RUANGAN BERSIFAT PERMANEN', 0.20, 50000, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 2, 'BULAN', nil],
    [3760, '1104', '09', '02', 'REKLAME BERSIFAT TIDAK PERMANEN', 0.20, 50000, nil, nil, 2017, nil, nil, nil, nil, 16, '2017-01-06 03:26:28', 16, '2017-01-06 03:26:28', 2, 'BULAN', nil],
    
    [3454, '1105', '00', '00', 'PAJAK PENERANGAN JALAN', nil, nil, nil, nil, 2017, nil, nil, 0, 0, 3085, 42, '2017-01-03 17:30:03', 42, '2017-01-03 17:30:03'],
    [3320, '1105', '01', '06', 'Dihasilkan Sendiri', 0.07, nil, nil, nil, 2017, nil, nil, 0, 0, 3096, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3320, '1105', '02', '06', 'Sumber Lain', 0.07, nil, nil, nil, 2017, nil, nil, 0, 0, 3096, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    
    [3407, '1111', '00', '00', 'PAJAK MINRL BKN LGAM & BATUAN', nil, nil, nil, nil, 2017, nil, nil, 0, 0, 3099, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3542, '1111', '01', '00', 'Asbes', 0.15, 30000, nil, nil, 2017, nil, nil, 0, 0, 3110, 42, '2017-01-03 17:30:03', 42, '2017-01-03 17:30:03'],
    [3543, '1111', '02', '00', 'Batu Tulis', 0.15, 25000, nil, nil, 2017, nil, nil, 0, 0, 3106, 42, '2017-01-03 17:30:03', 42, '2017-01-03 17:30:03'],
    [3544, '1111', '03', '00', 'Batu Setengah Permata', 0.15, 20000, nil, nil, 2017, nil, nil, 0, 0, 3105, 42, '2017-01-03 17:30:03', 42, '2017-01-03 17:30:03'],
    [3476, '1111', '04', '00', 'Batu Kapur', 0.15, 0, nil, nil, 2017, nil, nil, 0, 0, 3114, 42, '2017-01-03 17:30:03', 42, '2017-01-03 17:30:03'],
    [3455, '1111', '05', '00', 'Batu Apung', 0.15, 0, nil, nil, 2017, nil, nil, 0, 0, 3108, 42, '2017-01-03 17:30:03', 42, '2017-01-03 17:30:03'],
    [3423, '1111', '06', '00', 'Batu Permata', 0.15, 20000, nil, nil, 2017, nil, nil, 0, 0, 3107, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3396, '1111', '07', '00', 'Kaolin', 0.15, 1, nil, nil, 2017, nil, nil, 0, 0, 3113, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3400, '1111', '08', '00', 'Dolomit', 0.15, 10000, nil, nil, 2017, nil, nil, 0, 0, 3111, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3401, '1111', '09', '00', 'Pasir dan Kerikil', 0.15, 13000, nil, nil, 2017, nil, nil, 0, 0, 3104, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3408, '1111', '10', '00', 'Pasir Kuarsa', 0.15, 13000, nil, nil, 2017, nil, nil, 0, 0, 3109, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3340, '1111', '11', '00', 'Tanah Liat', 0.15, 40000, nil, nil, 2017, nil, nil, 0, 0, 3101, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    
    [3351, '1107', '00', '00', 'PAJAK PARKIR', nil, nil, nil, nil, 2017, nil, nil, 0, 0, 3140, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3282, '1107', '01', '00', 'Pajak Parkir', 0.2, nil, nil, nil, 2017, nil, nil, 0, 0, 3002, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    
    [3308, '1108', '00', '00', 'PAJAK AIR TANAH', nil, nil, nil, nil, 2017, nil, nil, 0, 0, 3125, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3309, '1108', '01', '00', 'Pajak Air Tanah Pengambilan', 0.2, nil, nil, nil, 2017, nil, nil, 0, 0, 3127, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3310, '1108', '02', '00', 'Pajak Air Tanah Pemanfaatan', 0.2, nil, nil, nil, 2017, nil, nil, 0, 0, 3129, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    
    [3322, '1109', '00', '00', 'PAJAK SARANG BURUNG WALET', nil, nil, nil, nil, 2017, nil, nil, 0, 0, 3004, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3322, '1109', '01', '00', 'Pajak Sarang Burung Walet Pengambilan', 0.1, nil, nil, nil, 2017, nil, nil, 0, 0, 3004, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
    [3322, '1109', '02', '00', 'Pajak Sarang Burung Walet Pengusahaan', 0.1, nil, nil, nil, 2017, nil, nil, 0, 0, 3004, 42, '2017-01-03 17:30:02', 42, '2017-01-03 17:30:02'],
     
]

pajak_list.each do |x|
    Rekening.create!(kode:x[1], jenis_kode:x[2], turunan_kode:x[3], nama_rekening:x[4], tahun:x[9], tarif:x[6], persen:(x[5]*100 unless x[5] == nil), status: (x[18] if x[18].is_a? Integer), satuan_masa_pajak:x[19])
end 

list_usaha = [
    ['01', 'PT', -1, '2015-11-09 16:35:15.943', 16, '2015-11-18 10:43:56'],
    ['02', 'CV', -1, '2015-11-09 16:35:15.943', -1, '2015-11-09 16:35:15.943'],
    ['03', 'UD', -1, '2015-11-09 16:35:15.943', -1, '2015-11-09 16:35:15.943'],
    ['04', 'HOTEL', -1, '2015-11-09 16:35:15.943', -1, '2015-11-09 16:35:15.943'],
    ['05', 'RUMAH MAKAN', -1, '2015-11-09 16:35:15.943', -1, '2015-11-09 16:35:15.943'],
    ['06', 'WARUNG', -1, '2015-11-09 16:35:15.943', -1, '2015-11-09 16:35:15.943'],
    ['07', 'CATERING', -1, '2015-11-09 16:35:15.943', -1, '2015-11-09 16:35:15.943'],
    ['08', 'CAFETARIA', -1, '2015-11-09 16:35:15.943', -1, '2015-11-09 16:35:15.943'],
    ['09', 'HIBURAN', -1, '2015-11-09 16:35:15.943', -1, '2015-11-09 16:35:15.943'],
    ['10', 'YAYASAN/KOPERASI', -1, '2015-11-09 16:35:15.943', -1, '2015-11-09 16:35:15.943'],
    ['11', 'PERKANTORAN', -1, '2015-11-09 16:35:15.943', -1, '2015-11-09 16:35:15.943'],
    ['12', 'PRIBADI', -1, '2015-11-09 16:35:15.943', -1, '2015-11-09 16:35:15.943'],
    ['13', 'LAIN-LAIN', -1, '2015-11-09 16:35:15.943', -1, '2015-11-09 16:35:15.943']
]

list_usaha.each do |y|
    Usaha.create!(kode_usaha:y[0], nama_usaha:y[1])
end

list_bidang = [
['01', 'DINAS PENGELOLA KEUANGAN DAN ASSET DAERAH', 'DPKAD', -1, '2016-07-26 07:24:01.561', -1, '2016-07-26 07:24:01.561'],
['02', 'PENAGIHAN', 'PNGH', -1, '2016-07-26 07:24:19.421', -1, '2016-07-26 07:24:19.421'],
['04', 'BADAN PENDAPATAN DAERAH', 'BAPENDA', -1, '2017-01-03 17:09:50.115', -1, '2017-01-03 17:09:50.115'],
['03', 'PENDAPATAN I', 'PDP 1', -1, '2015-02-17 10:38:32.521', -1, '2015-02-17 10:38:32.521']]

list_bidang.each do |b|
    Bidang.create!(kode_bidang:b[0], nama_bidang:b[1])
end

list_seksi = [
['01', 'PENETAPAN DAN PELAYANAN', nil, nil, nil, 16, '2015-11-18 10:16:16', 16, '2015-11-18 10:16:16', '03', ''],
['02', 'PENDATAAN DAN PENILAIAN', nil, nil, nil, 16, '2015-11-18 10:17:08', 16, '2015-11-18 10:17:08', '03', ''],
['04', 'PERHITUNGAN DAN PENETAPAN', nil, nil, nil, 16, '2015-11-18 10:18:26', 16, '2015-11-18 10:18:26', '03', ''],
['06', 'PENGENDALIAN', nil, nil, nil, 16, '2015-11-18 10:19:19', 16, '2015-11-18 10:19:19', '03', ''],
['08', 'PENGGALIAN SUMBER LAIN-LAIN', nil, nil, nil, 16, '2015-11-18 10:20:24', 16, '2015-11-18 10:20:24', '03', ''],
['03', 'KEBERATAN DAN ANGSURAN', nil, nil, nil, 16, '2015-11-18 10:17:44', 27, '2016-07-26 16:25:11', '02', ''],
['10', 'KEPALA DPKAD KAB. BENGKAYANG', nil, nil, nil, 27, '2016-07-26 16:29:11', 27, '2016-07-26 16:29:11', '01', ''],
['11', 'MANTAN', nil, nil, nil, 27, '2016-07-26 16:41:38', 27, '2016-07-26 16:41:38', '04', ''],
['07', 'PENAGIHAN', nil, nil, nil, 16, '2015-11-18 10:19:44', 27, '2016-07-26 16:50:04', '02', ''],
['09', 'PEMBUKUAN DAN PENERIMAAN', nil, nil, nil, 16, '2015-11-18 10:21:11', 27, '2016-07-26 16:50:35', '02', ''],
['05', 'EVALUASI DAN PELAPORAN', nil, nil, nil, 16, '2015-11-18 10:18:52', 27, '2016-09-14 05:23:57', '02', ''],
['12', 'KEPALA BADAN PENDAPATAN DAERAH', nil, nil, nil, 27, '2017-01-04 02:11:16', 27, '2017-01-04 02:11:16', '04', 'KA. BAPENDA']
]

list_seksi.each do |b|
    Seksi.create!(kode_seksi:b[0], nama_seksi:b[1], singkatan:b[10], bidang_id:Bidang.find_by_kode_bidang(b[9]).id)
end

list_jabatan = [
['03', 'KABID. PENAGIHAN DAN PENGENDALIAN', nil, -1, '2015-11-17 01:31:24.764', -1, '2015-11-17 01:31:24.764', nil],
['04', 'KEPALA BIDANG PENDAPATAN I', nil, -1, '2015-11-17 01:31:24.764', -1, '2015-11-17 01:31:24.764', nil],
['06', 'KASI. PENETAPAN DAN PELAYANAN', nil, -1, '2015-11-17 01:31:24.764', -1, '2015-11-17 01:31:24.764', nil],
['07', 'KASI. PENDATAAN DAN PENILAIAN', nil, -1, '2015-11-17 01:31:24.764', -1, '2015-11-17 01:31:24.764', nil],
['10', 'KASI. PENETAPAN DAN PELAYANAN', nil, -1, '2015-11-17 01:31:24.764', -1, '2015-11-17 01:31:24.764', nil],
['11', 'KABID. PENAGIHAN DAN PENGENDALIAN', nil, -1, '2015-11-17 01:31:24.764', -1, '2015-11-17 01:31:24.764', nil],
['12', 'KASI. KEBERATAN DAN ANGSURAN', nil, -1, '2015-11-17 01:31:24.764', -1, '2015-11-17 01:31:24.764', nil],
['13', 'KASI. PERHITUNGAN DAN PENETAPAN', nil, -1, '2015-11-17 01:31:24.764', -1, '2015-11-17 01:31:24.764', nil],
['14', 'KASI. EVALUASI DAN PELAPORAN', nil, -1, '2015-11-17 01:31:24.764', -1, '2015-11-17 01:31:24.764', nil],
['16', 'KASI. PENGENDALIAN', nil, -1, '2015-11-17 01:31:24.764', -1, '2015-11-17 01:31:24.764', nil],
['17', 'KASI PENAGIHAN', nil, -1, '2015-11-17 01:31:24.764', -1, '2015-11-17 01:31:24.764', nil],
['19', 'KASI. PENGGALIAN SUMBER LAIN-LAIN', nil, -1, '2015-11-17 01:31:24.764', -1, '2015-11-17 01:31:24.764', nil],
['20', 'KASI. PEMBUKUAN PENERIMAAN', nil, -1, '2015-11-17 01:31:24.764', -1, '2015-11-17 01:31:24.764', nil],
['21', 'PEMEGANG KAS', nil, -1, '2015-11-17 01:31:24.764', -1, '2015-11-17 01:31:24.764', nil],
['22', 'BENDAHARAWAN KHUSUS PENERIMA', nil, -1, '2015-11-17 01:31:24.764', -1, '2015-11-17 01:31:24.764', nil],
['23', 'BENDAHARAWAN KHUSUS BENDA BERHARGA', nil, -1, '2015-11-17 01:31:24.764', -1, '2015-11-17 01:31:24.764', nil],
['24', 'STAF PEMBANTU BKP', nil, -1, '2015-11-17 01:31:24.764', -1, '2015-11-17 01:31:24.764', nil],
['26', 'STAF PEMBANTU BKBB', nil, -1, '2015-11-17 01:31:24.764', -1, '2015-11-17 01:31:24.764', nil],
['30', 'STAF PENDATAAN', nil, -1, '2015-11-17 01:31:24.764', -1, '2015-11-17 01:31:24.764', nil],
['31', 'STAF PENETAPAN', nil, -1, '2015-11-17 01:31:24.764', -1, '2015-11-17 01:31:24.764', nil],
['33', 'STAF PENAGIHAN', nil, -1, '2015-11-17 01:31:24.764', -1, '2015-11-17 01:31:24.764', nil],
['00', 'BUPATI', nil, 16, '2015-11-18 10:24:19', 16, '2015-11-18 10:24:19', ' '],
['34', 'MANTAN', '', 27, '2016-07-26 16:43:41', 27, '2016-07-26 16:43:41', ' '],
['35', 'KABID. PENGGALIAN POTENSI', '', 16, '2016-08-24 09:08:48', 16, '2016-08-24 09:08:48', ' '],
['36', 'KEPALA BADAN PENDAPATAN DAERAH', 'KA. BAPENDA', 27, '2017-01-04 02:13:42', 27, '2017-01-04 02:13:42', ' '],
['01', 'KEPALA BADAN PENDAPATAN DAERAH', 'KEPALA BAPENDA', 16, '2015-12-29 07:08:41', 16, '2017-01-09 18:24:13', ' ']
]

list_jabatan.each do |b|
    Jabatan.create!(kode_jabatan:b[0], nama_jabatan:b[1], singkatan:b[2])
end

golongan_pangkat = [
['PEMBINA UTAMA MUDA', 'IV', 'C'],
['PEMBINA TK. I', 'IV', 'B'],
['PEMBINA', 'IV', 'A'],
['PENATA TK. I', 'III', 'D'],
['PENATA', 'III', 'C'],
['PENATA MUDA TK. I', 'III', 'B'],
['PENATA MUDA', 'III', 'A'],
['PENGATUR TK. I', 'II', 'D'],
['PENGATUR', 'II', 'C'],
]
golongan_pangkat.each do |b|
    Golongan.create!(nama_pangkat:b[0], golongan:b[1], ruang:b[2])
end

Ttd.create!([
    {nama_surat:"Surat Teguran", baris1:"An. Kepala Badan Pendapatan Daerah", baris2:"Kepala Bidang Pendapatan I"},
    {nama_surat:"Tanda Bukti Penyetoran", baris1:"Mengetahui,", baris2:"Bendahara Penerimaan / Bendahara Penerimaan Pembantu"},
    {nama_surat:"SKP", baris1:"KEPALA BADAN PENDAPATAN DAERAH"},
    {nama_surat:"STS", baris1:"Penyetor"}
])
