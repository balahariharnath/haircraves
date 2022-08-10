class Api::AddressesController < ApplicationController
  load_and_authorize_resource

  def address_list
    @addresses = current_user.addresses
    render json: {addresses: @addresses.as_json}
  end

  def create
    @address = current_user.addresses.create(address_params)
    render json: {message: "Address created successfully", address: @address.as_json(include: [:user])}, status: :created
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    render json: {message: "Address updated successfully", address: @address.as_json(include: [:user])}, status: :found
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    render json: {message: "Address deleted successfully"}
  end

  private

  def address_params
    params.require(:address).permit(:door_no, :street, :city, :state, :pincode)
  end
end