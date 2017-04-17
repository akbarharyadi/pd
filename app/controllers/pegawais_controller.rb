class PegawaisController < ApplicationController
  before_action :set_pegawai, only: [:show, :edit, :update, :destroy]
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  add_breadcrumb '<i class="ace-icon fa fa-home home-icon"></i> Home'.html_safe, :root_path
  add_breadcrumb ' Index Pegawai'.html_safe, :pegawais_path

  # GET /pegawais
  # GET /pegawais.json
  def index
    pegawais_scope = Pegawai.all
    pegawais_scope = pegawais_scope.like(params[:filter]) if params[:filter]
    @pegawai = smart_listing_create(:pegawais, pegawais_scope, partial: "pegawais/listing", default_sort: {id:"asc"})
  end

  # GET /pegawais/1
  # GET /pegawais/1.json
  def show
     add_breadcrumb @pegawai.nama_pegawai.capitalize
  end

  # GET /pegawais/new
  def new
    add_breadcrumb 'Buat Baru'
    @pegawai = Pegawai.new
  end

  # GET /pegawais/1/edit
  def edit
    add_breadcrumb 'Edit : ' + @pegawai.nip
  end

  # POST /pegawais
  # POST /pegawais.json
  def create
    @pegawai = Pegawai.new(pegawai_params)

    respond_to do |format|
      if @pegawai.save
        format.html { redirect_to @pegawai, notice: 'Pegawai berhasil tersimpan.' }
        format.json { render :show, status: :created, location: @pegawai }
      else
        format.html { render :new }
        format.json { render json: @pegawai.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pegawais/1
  # PATCH/PUT /pegawais/1.json
  def update
    respond_to do |format|
      if @pegawai.update(pegawai_params)
        format.html { redirect_to @pegawai, notice: 'Pegawai berhasil tersimpan.' }
        format.json { render :show, status: :ok, location: @pegawai }
      else
        format.html { render :edit }
        format.json { render json: @pegawai.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pegawais/1
  # DELETE /pegawais/1.json
  def destroy
    @pegawai.destroy
    respond_to do |format|
      format.html { redirect_to pegawais_url, notice: 'Pegawai berhasil terhapus.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pegawai
      @pegawai = Pegawai.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pegawai_params
      params.require(:pegawai).permit(:nama_pegawai, :nip, :bidang_id, :seksi_id, :jabatan_id, :golongan_id, :filter)
    end
end
