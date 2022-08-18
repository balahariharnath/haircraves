class Api::UsersController < ApplicationController

  # before_action authenticate_user!
  # load_and_authorize_resource
  skip_before_action :authenticate_user!, only: [:create_user, :forgot_password]

  def check_api
    render json: {data: "hi"}, status: :created
  end

  def create_user
    role = Role.find_by_role_name('customer')
    if role.present?
      @user = role.users.build(user_params)
      if @user.save
        render json: {message: "Signed up successfully", data: @user}, status: :created
      else
        render json: {error: @user.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json: {error: "Please check the type"}, status: :unprocessable_entity
    end
  end

  def update_profile
    role = Role.find_by_role_name(params[:type])
    if role.present?
      @user = current_user
      @user.assign_attributes(user_params.merge!(role_id: role.id))
      if @user.save
        render json: { message: "Profile created successfully", data: @user.as_json(methods: [:profile_image_url, :cover_image_url])}, status: :created
      else
        render json: {error: @user.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json: {error: "Please check the type"}, status: :unprocessable_entity
    end
  end

  # def forgot_password
  #   if params[:email].blank? # check if email is present
  #     return render json: {error: 'Email not present'}
  #   end
  #
  #   user = User.find_by(email: params[:email]) # if present find user by email
  #
  #   if user.present?
  #     user.generate_password_token! #generate pass token
  #     Devise::Mailer.welcome_reset_password_instructions(user).deliver_now
  #     render json: {status: 'ok'}, status: :ok
  #   else
  #     render json: {error: ['Email address not found. Please check and try again.']}, status: :not_found
  #   end
  # end

  def forgot_password
    @user = User.find_by_email(params[:email])
    if @user.present? && @user.confirmed?
      @user.send_reset_password_instructions
      render json: {message: "We have sent you an email to your registered email address with a link to reset your password"}
    else
      render json: {data: "no email / not confirmed"}
    end
  end

  private

  def user_params
    params.require(:user).permit!
  end
end
