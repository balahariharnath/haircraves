# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # can :manage, :all
    can :manage, Comment, :user_id => user.id
    if user.role.role_name == 'business_owner' || user.role.role_name == 'stylist'
      can :manage, Service, :user_id => user.id
      can :manage, Availability, :user_id => user.id
      can :manage, Category, :user_id => user.id
      can :manage, Item, :user_id => user.id
      can [:post_details, :post_list, :like_post], Post
      can [:update, :my_bookings, :requests], Appointment, :stylist_id => user.id
      can :manage, Portfolio, :user_id => user.id
      can [:my_orders, :update, :order_status], Order, :seller_id => user.id
    else
      if user.role.role_name == 'customer'
        can [:service_list, :profile, :service_categories, :service_providers], Service
        can :manage, Post, :user_id => user.id
        can :category_list, Category
        can [:items_list, :details], Item
        can :manage, Appointment, :user_id => user.id
        can :manage, Address, :user_id => user.id
        can :manage, Card, :user_id => user.id
        can :manage, Cart, :user_id => user.id
        can :manage, ItemFavorite, :user_id => user.id
        can :manage, ServiceFavorite, :user_id => user.id
        can [:my_orders, :create, :item_rating], Order, :user_id => user.id
      end
    end
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
