class Api::GeneralInfosController < ApplicationController
  skip_before_action :authenticate_user!

  # def get_roles
  #   roles = Role.where.not(role_name: "customer")
  #   render json: { data: roles}
  # end
end