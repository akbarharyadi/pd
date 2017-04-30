# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170422112542) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bidangs", force: :cascade do |t|
    t.string   "kode_bidang"
    t.string   "nama_bidang"
    t.datetime "deleted_at"
    t.string   "slug"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["deleted_at"], name: "index_bidangs_on_deleted_at", using: :btree
    t.index ["slug"], name: "index_bidangs_on_slug", using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "golongans", force: :cascade do |t|
    t.string   "nama_pangkat"
    t.string   "golongan"
    t.string   "ruang"
    t.datetime "deleted_at"
    t.string   "slug"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["deleted_at"], name: "index_golongans_on_deleted_at", using: :btree
    t.index ["slug"], name: "index_golongans_on_slug", using: :btree
  end

  create_table "jabatans", force: :cascade do |t|
    t.string   "kode_jabatan"
    t.string   "nama_jabatan"
    t.string   "singkatan"
    t.datetime "deleted_at"
    t.string   "slug"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["deleted_at"], name: "index_jabatans_on_deleted_at", using: :btree
    t.index ["slug"], name: "index_jabatans_on_slug", using: :btree
  end

  create_table "kecamatans", force: :cascade do |t|
    t.string   "kode",       limit: 3
    t.string   "nama",       limit: 50
    t.datetime "deleted_at"
    t.string   "slug"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["deleted_at"], name: "index_kecamatans_on_deleted_at", using: :btree
    t.index ["slug"], name: "index_kecamatans_on_slug", using: :btree
  end

  create_table "kelurahans", force: :cascade do |t|
    t.string   "kode",         limit: 3
    t.string   "nama",         limit: 50
    t.integer  "kecamatan_id"
    t.datetime "deleted_at"
    t.string   "slug"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["deleted_at"], name: "index_kelurahans_on_deleted_at", using: :btree
    t.index ["slug"], name: "index_kelurahans_on_slug", using: :btree
  end

  create_table "pegawais", force: :cascade do |t|
    t.string   "nama_pegawai"
    t.string   "nip"
    t.integer  "bidang_id"
    t.integer  "seksi_id"
    t.integer  "jabatan_id"
    t.integer  "golongan_id"
    t.datetime "deleted_at"
    t.string   "slug"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["deleted_at"], name: "index_pegawais_on_deleted_at", using: :btree
    t.index ["slug"], name: "index_pegawais_on_slug", using: :btree
  end

  create_table "pendaftarans", force: :cascade do |t|
    t.string   "no_pendaftaran"
    t.string   "nama_usaha"
    t.string   "alamat_usaha"
    t.integer  "kecamatan_id"
    t.integer  "kelurahan_id"
    t.string   "no_telp_usaha"
    t.string   "nama_pemilik"
    t.string   "alamat_pemilik"
    t.string   "no_telp_pemilik"
    t.string   "npwpd"
    t.date     "tgl_npwpd"
    t.integer  "usaha_id"
    t.string   "no_reg_pendaftaran"
    t.date     "tgl_daftar"
    t.datetime "deleted_at"
    t.string   "slug"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "status"
    t.index ["deleted_at"], name: "index_pendaftarans_on_deleted_at", using: :btree
    t.index ["slug"], name: "index_pendaftarans_on_slug", using: :btree
  end

  create_table "pendataans", force: :cascade do |t|
    t.date     "tgl_data"
    t.integer  "tahun_spt"
    t.integer  "pendaftaran_id"
    t.integer  "rekening_id"
    t.date     "periode_awal"
    t.date     "periode_akhir"
    t.float    "omzet"
    t.float    "jumlah_pajak"
    t.string   "no_pendataan"
    t.datetime "deleted_at"
    t.string   "slug"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.float    "pemakaian_daya"
    t.float    "volume_pemakaian"
    t.float    "jumlah_volume"
    t.integer  "status"
    t.integer  "pajak_rokok"
    t.float    "nilai_reklame"
    t.float    "npa"
    t.index ["deleted_at"], name: "index_pendataans_on_deleted_at", using: :btree
    t.index ["slug"], name: "index_pendataans_on_slug", using: :btree
  end

  create_table "penetapans", force: :cascade do |t|
    t.integer  "no_tetap"
    t.date     "tgl_tetap"
    t.integer  "no_setor"
    t.integer  "pendataan_id"
    t.float    "pemakaian_daya_teliti"
    t.float    "volume_pemakaian_teliti"
    t.float    "jumlah_volume_teliti"
    t.integer  "pajak_rokok_teliti"
    t.float    "nilai_reklame_teliti"
    t.float    "npa_teliti"
    t.float    "omzet_teliti"
    t.float    "jumlah_pajak_teliti"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.float    "denda"
    t.date     "tgl_setor"
  end

  create_table "rekenings", force: :cascade do |t|
    t.string   "kode"
    t.string   "jenis_kode"
    t.string   "turunan_kode"
    t.string   "nama_rekening"
    t.integer  "tahun"
    t.float    "tarif"
    t.float    "persen"
    t.datetime "deleted_at"
    t.string   "slug"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["deleted_at"], name: "index_rekenings_on_deleted_at", using: :btree
    t.index ["slug"], name: "index_rekenings_on_slug", using: :btree
  end

  create_table "seksis", force: :cascade do |t|
    t.string   "kode_seksi"
    t.string   "nama_seksi"
    t.string   "singkatan"
    t.integer  "bidang_id"
    t.datetime "deleted_at"
    t.string   "slug"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_seksis_on_deleted_at", using: :btree
    t.index ["slug"], name: "index_seksis_on_slug", using: :btree
  end

  create_table "ttds", force: :cascade do |t|
    t.string   "baris1"
    t.string   "baris2"
    t.string   "baris3"
    t.integer  "pegawai_id"
    t.datetime "deleted_at"
    t.string   "slug"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "nama_surat"
    t.index ["deleted_at"], name: "index_ttds_on_deleted_at", using: :btree
    t.index ["slug"], name: "index_ttds_on_slug", using: :btree
  end

  create_table "usahas", force: :cascade do |t|
    t.string   "kode_usaha", limit: 2
    t.string   "nama_usaha"
    t.datetime "deleted_at"
    t.string   "slug"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["deleted_at"], name: "index_usahas_on_deleted_at", using: :btree
    t.index ["slug"], name: "index_usahas_on_slug", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "wilayahs", force: :cascade do |t|
    t.string   "nama_wilayah"
    t.string   "jenis_wilayah"
    t.string   "pemimpin"
    t.string   "ibu_kota"
    t.string   "nama_badan"
    t.string   "alamat_badan"
    t.string   "telp_badan"
    t.string   "slug"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "singkatan"
    t.string   "fax"
    t.string   "kode_pos"
  end

end
