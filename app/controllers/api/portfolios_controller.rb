class Api::PortfoliosController < ApplicationController
  load_and_authorize_resource

  def create
    current_user.portfolio.destroy if current_user.portfolio.present?
    @portfolio = current_user.build_portfolio(portfolio_params)
    @portfolio.save
    render json: {portfolio: @portfolio.as_json(include: {user: {methods: [:profile_image_url, :cover_image_url]}})}, status: :created
  end

  def update
    @portfolio.update(portfolio_params)
    render json: {portfolio: @portfolio.as_json(include: {user: {methods: [:profile_image_url, :cover_image_url]}})}, status: :found
  end

  def destroy
    @portfolio.destroy
    render json: {message: "porfolio destroyed successfully"}
  end

  def index
    @portfolio = current_user.portfolio
    return render json: {portfolio: @portfolio.as_json(include: {user: {methods: [:profile_image_url, :cover_image_url]}})} if @portfolio.present?
    render json: {message: "No portfolio"}
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:title, :content)
  end
end
