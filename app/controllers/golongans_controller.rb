class GolongansController < ApplicationController
  before_action :set_golongan, only: [:show, :edit, :update, :destroy]
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  add_breadcrumb '<i class="ace-icon fa fa-home home-icon"></i> Home'.html_safe, :root_path
  add_breadcrumb ' Index Golongan'.html_safe, :golongans_path

  # GET /golongans
  # GET /golongans.json
  def index
    golongans_scope = Golongan.all
    golongans_scope = golongans_scope.like(params[:filter]) if params[:filter]
    @bidangs = smart_listing_create(:golongans, golongans_scope, partial: "golongans/listing", default_sort: {id: "asc"})
  end

  # GET /golongans/1
  # GET /golongans/1.json
  def show
    add_breadcrumb @golongan.nama_pangkat.capitalize
  end

  # GET /golongans/new
  def new
    add_breadcrumb 'Buat Baru'
    @golongan = Golongan.new
  end

  # GET /golongans/1/edit
  def edit
    add_breadcrumb 'Edit : ' + @golongan.nama_pangkat.capitalize
  end

  # POST /golongans
  # POST /golongans.json
  def create
    @golongan = Golongan.new(golongan_params)

    respond_to do |format|
      if @golongan.save
        format.html { redirect_to @golongan, notice: 'Golongan berhasil tersimpan.' }
        format.json { render :show, status: :created, location: @golongan }
      else
        format.html { render :new }
        format.json { render json: @golongan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /golongans/1
  # PATCH/PUT /golongans/1.json
  def update
    respond_to do |format|
      if @golongan.update(golongan_params)
        format.html { redirect_to @golongan, notice: 'Golongan berhasil tersimpan.' }
        format.json { render :show, status: :ok, location: @golongan }
      else
        format.html { render :edit }
        format.json { render json: @golongan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /golongans/1
  # DELETE /golongans/1.json
  def destroy
    @golongan.destroy
    respond_to do |format|
      format.html { redirect_to golongans_url, notice: 'Golongan berhasil terhapus' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_golongan
      @golongan = Golongan.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def golongan_params
      params.require(:golongan).permit(:nama_pangkat, :golongan, :ruang,:filter)
    end
end
