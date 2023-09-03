class VonagesController < ApplicationController
  before_action :set_vonage, only: %i[ show edit update destroy ]

  # GET /vonages or /vonages.json
  def index
    @vonages = Vonage.all
  end

  # GET /vonages/1 or /vonages/1.json
  def show
  end

  # GET /vonages/new
  def new
    @vonage = Vonage.new
  end

  # GET /vonages/1/edit
  def edit
  end

  # POST /vonages or /vonages.json
  def create
    @vonage = Vonage.new(vonage_params)

    respond_to do |format|
      if @vonage.save
        format.html { redirect_to vonage_url(@vonage), notice: "Vonage was successfully created." }
        format.json { render :show, status: :created, location: @vonage }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vonage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vonages/1 or /vonages/1.json
  def update
    respond_to do |format|
      if @vonage.update(vonage_params)
        format.html { redirect_to vonage_url(@vonage), notice: "Vonage was successfully updated." }
        format.json { render :show, status: :ok, location: @vonage }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vonage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vonages/1 or /vonages/1.json
  def destroy
    @vonage.destroy

    respond_to do |format|
      format.html { redirect_to vonages_url, notice: "Vonage was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vonage
      @vonage = Vonage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vonage_params
      params.fetch(:vonage, {})
    end
end
