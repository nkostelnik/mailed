class AddressesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  skip_before_filter  :verify_authenticity_token, only: [:create]

  def index
    @addresses = current_user.addresses
  end

  def show
  end

  def new
    @address = Address.new
  end

  def edit
  end

  def create
    respond_to do |format|
      @address = current_user.addresses.build(address_params)
      if @address.save
        format.html { redirect_to root_path }
        format.json { render :create, status: :ok, location: @address }
      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @address.update(address_params)
      redirect_to root_path, notice: 'Address was successfully updated.'
    end
  end

  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find_by!(mask: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params[:address].permit(:name)
    end
end
