class UsahasController < ApplicationController
  before_action :set_usaha, only: [:show, :edit, :update, :destroy]
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  add_breadcrumb '<i class="ace-icon fa fa-home home-icon"></i> Home'.html_safe, :root_path
  add_breadcrumb ' Index Usaha'.html_safe, :usahas_path
  # GET /usahas
  # GET /usahas.json
  def index
    usaha_scope = Usaha.all
    usaha_scope = usaha_scope.like(params[:filter]) if params[:filter]
    @usaha = smart_listing_create(:usahas, usaha_scope, partial: "usahas/listing", default_sort: {kode_usaha: "asc"})
  end

  # GET /usahas/1
  # GET /usahas/1.json
  def show
    add_breadcrumb @usaha.nama_usaha.capitalize
  end

  # GET /usahas/new
  def new
    add_breadcrumb 'Buat Baru'
    @usaha = Usaha.new
  end

  # GET /usahas/1/edit
  def edit
    add_breadcrumb 'Edit ' + @usaha.nama_usaha.capitalize
  end

  # POST /usahas
  # POST /usahas.json
  def create
    @usaha = Usaha.new(usaha_params)

    respond_to do |format|
      if @usaha.save
        format.html { redirect_to @usaha, notice: 'Jenis Usaha berhasil tersimpan.' }
        format.json { render :show, status: :created, location: @usaha }
      else
        format.html { render :new }
        format.json { render json: @usaha.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usahas/1
  # PATCH/PUT /usahas/1.json
  def update
    respond_to do |format|
      if @usaha.update(usaha_params)
        format.html { redirect_to @usaha, notice: 'Jenis Usaha berhasil tersimpan.' }
        format.json { render :show, status: :ok, location: @usaha }
      else
        format.html { render :edit }
        format.json { render json: @usaha.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usahas/1
  # DELETE /usahas/1.json
  def destroy
    @usaha.destroy
    respond_to do |format|
      format.html { redirect_to usahas_url, notice: 'Jenis Usaha berhasil terhapus' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usaha
      @usaha = Usaha.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usaha_params
      params.require(:usaha).permit(:kode_usaha, :nama_usaha, :filter)
    end
end
