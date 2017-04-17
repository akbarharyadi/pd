class JabatansController < ApplicationController
  before_action :set_jabatan, only: [:show, :edit, :update, :destroy]
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  add_breadcrumb '<i class="ace-icon fa fa-home home-icon"></i> Home'.html_safe, :root_path
  add_breadcrumb ' Index Jabatan'.html_safe, :jabatans_path

  # GET /jabatans
  # GET /jabatans.json
  def index
    jabatans_scope = Jabatan.all
    jabatans_scope = jabatans_scope.like(params[:filter]) if params[:filter]
    @bidangs = smart_listing_create(:jabatans, jabatans_scope, partial: "jabatans/listing", default_sort: {kode_jabatan: "asc"})
  end

  # GET /jabatans/1
  # GET /jabatans/1.json
  def show
    add_breadcrumb @jabatan.nama_jabatan.capitalize
  end

  # GET /jabatans/new
  def new
    add_breadcrumb 'Buat Baru'
    @jabatan = Jabatan.new
  end

  # GET /jabatans/1/edit
  def edit
    add_breadcrumb 'Edit: ' + @jabatan.nama_jabatan.capitalize
  end

  # POST /jabatans
  # POST /jabatans.json
  def create
    @jabatan = Jabatan.new(jabatan_params)

    respond_to do |format|
      if @jabatan.save
        format.html { redirect_to @jabatan, notice: 'Jabatan berhasil tersimpan.' }
        format.json { render :show, status: :created, location: @jabatan }
      else
        format.html { render :new }
        format.json { render json: @jabatan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jabatans/1
  # PATCH/PUT /jabatans/1.json
  def update
    respond_to do |format|
      if @jabatan.update(jabatan_params)
        format.html { redirect_to @jabatan, notice: 'Jabatan berhasil tersimpan.' }
        format.json { render :show, status: :ok, location: @jabatan }
      else
        format.html { render :edit }
        format.json { render json: @jabatan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jabatans/1
  # DELETE /jabatans/1.json
  def destroy
    @jabatan.destroy
    respond_to do |format|
      format.html { redirect_to jabatans_url, notice: 'Jabatan berhasil terhapus.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_jabatan
      @jabatan = Jabatan.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def jabatan_params
      params.require(:jabatan).permit(:kode_jabatan, :nama_jabatan, :singkatan)
    end
end
