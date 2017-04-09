class SeksisController < ApplicationController
  before_action :set_seksi, only: [:show, :edit, :update, :destroy]
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  add_breadcrumb '<i class="ace-icon fa fa-home home-icon"></i> Home'.html_safe, :root_path
  add_breadcrumb ' Index Seksi'.html_safe, :seksis_path

  # GET /seksis
  # GET /seksis.json
  def index
    seksis_scope = Seksi.joins(:bidang).all
    seksis_scope = seksis_scope.like(params[:filter]) if params[:filter]
    @seksis = smart_listing_create(:seksis, seksis_scope, partial: "seksis/listing", default_sort: {bidang_id:"asc", kode_seksi: "asc"})
  end

  # GET /seksis/1
  # GET /seksis/1.json
  def show
    add_breadcrumb @seksi.nama_seksi.capitalize
  end

  # GET /seksis/new
  def new
    add_breadcrumb 'Buat Baru'
    @seksi = Seksi.new
  end

  # GET /seksis/1/edit
  def edit
    add_breadcrumb 'Edit :' + @seksi.nama_seksi.capitalize
  end

  # POST /seksis
  # POST /seksis.json
  def create
    @seksi = Seksi.new(seksi_params)

    respond_to do |format|
      if @seksi.save
        format.html { redirect_to @seksi, notice: 'Seksi was successfully created.' }
        format.json { render :show, status: :created, location: @seksi }
      else
        format.html { render :new }
        format.json { render json: @seksi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seksis/1
  # PATCH/PUT /seksis/1.json
  def update
    respond_to do |format|
      if @seksi.update(seksi_params)
        format.html { redirect_to @seksi, notice: 'Seksi was successfully updated.' }
        format.json { render :show, status: :ok, location: @seksi }
      else
        format.html { render :edit }
        format.json { render json: @seksi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seksis/1
  # DELETE /seksis/1.json
  def destroy
    @seksi.destroy
    respond_to do |format|
      format.html { redirect_to seksis_url, notice: 'Seksi was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seksi
      @seksi = Seksi.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seksi_params
      params.require(:seksi).permit(:kode_seksi, :nama_seksi, :singkatan, :bidang_id, :seksis_scope)
    end
end
