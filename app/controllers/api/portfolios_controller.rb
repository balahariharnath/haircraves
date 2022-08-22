class Api::PortfoliosController < ApplicationController
  load_and_authorize_resource

  def create
    portfolio = current_user.portfolios.new(portfolio_params)
    portfolio.save
    render json: {portfolio: portfolio.as_json(methods: [:image_url, :video_url], include: {user: {methods: [:profile_image_url, :cover_image_url]}})}, status: :created
  end

  def update
    @portfolio.update(portfolio_params)
    render json: {portfolio: @portfolio.as_json(methods: [:image_url, :video_url], include: {user: {methods: [:profile_image_url, :cover_image_url]}})}, status: :found
  end

  def destroy
    @portfolio.destroy
    render json: {message: "porfolio destroyed successfully"}
  end

  def index
    portfolios = current_user.portfolios
    return render json: {portfolios: portfolios.as_json(methods: [:image_url, :video_url], include: {user: {methods: [:profile_image_url, :cover_image_url]}})} if @portfolios.present?
    render json: {message: "No portfolio"}
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:title, :content, :image, :video)
  end
end
