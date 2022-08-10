class Api::CardsController < ApplicationController
  load_and_authorize_resource

  def create
    if params[:card][:pay_pal_email].present?
      current_user.update(pay_pal_email: params[:card][:pay_pal_email])
      render json: {message: "PayPal email added successfully"}
    else
      @card = current_user.cards.new(card_params)
      if @card.save
        render json: {message: "Card created successfully", card: @card.as_json}, status: :created
      else
        render json: {error: @card.errors.full_messages}, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy
    render json: {message: "Card deleted successfully"}
  end

  private

  def card_params
    params.require(:card).permit(:card_number, :card_holder_name, :exp_date, :pay_pal_email)
  end
end