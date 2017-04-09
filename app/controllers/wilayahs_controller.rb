class WilayahsController < ApplicationController
  before_action :set_wilayah, only: [:show, :edit, :update, :destroy]

  # GET /wilayahs
  # GET /wilayahs.json
  # def index
  #   @wilayahs = Wilayah.all
  # end

  # GET /wilayahs/1
  # GET /wilayahs/1.json
  def show
    redirect_to controller: 'wilayahs', action: 'edit', id: 1
  end

  # GET /wilayahs/new
  # def new
  #   @wilayah = Wilayah.new
  # end

  # GET /wilayahs/1/edit
  def edit
    if @wilayah == nil
      @wilayah = Wilayah.new
    end
  end

  # POST /wilayahs
  # POST /wilayahs.json
  def create
    @wilayah = Wilayah.new(wilayah_params)

    respond_to do |format|
      if @wilayah.save
        format.html { redirect_to @wilayah, notice: 'Wilayah berhasil tersimpan.' }
        format.json { render :show, status: :created, location: @wilayah }
      else
        format.html { render :new }
        format.json { render json: @wilayah.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wilayahs/1
  # PATCH/PUT /wilayahs/1.json
  def update
    respond_to do |format|
      if @wilayah.update(wilayah_params)
        format.html { redirect_to @wilayah, notice: 'Wilayah Berhasil Tersimpan.' }
        format.json { render :show, status: :ok, location: @wilayah }
      else
        format.html { render :edit }
        format.json { render json: @wilayah.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wilayahs/1
  # DELETE /wilayahs/1.json
  # def destroy
  #   @wilayah.destroy
  #   respond_to do |format|
  #     format.html { redirect_to wilayahs_url, notice: 'Wilayah was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wilayah
      @wilayah = Wilayah.first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wilayah_params
      params.require(:wilayah).permit(:nama_wilayah, :jenis_wilayah, :pemimpin, :ibu_kota, :nama_badan, :alamat_badan, :telp_badan, :fax, :singkatan, :kode_pos)
    end
end
