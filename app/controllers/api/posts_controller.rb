class Api::PostsController < ApplicationController
  load_and_authorize_resource

  def create
    post = current_user.posts.create(post_params)
    render json: {data: post.as_json(include: {tag_users: {methods: [:profile_image_url, :cover_image_url]},
                                                items: {methods: [:image_urls, :video_url]}}, methods: [:image_url])}
  end

  def post_details
    post = Post.find(params[:id])
    render json: {post: post.as_json(include: {tag_users: {methods: [:profile_image_url, :cover_image_url]}, items: {methods:
                  [:image_urls, :video_url]}, :likes=> {}, :comments=> {include: {user: {methods: [:profile_image_url]}}}}, methods: [:image_url])}
  end

  def post_list
    if params[:service_category_id].present?
      posts = Post.where("service_category_id = ?", params[:service_category_id])
    else
      posts = Post.all
    end
    render json: {posts: posts.as_json(include: {tag_users: {methods: [:profile_image_url, :cover_image_url]}, items: {methods:
                         [:image_urls, :video_url]}, :likes=> {}, :comments=> {include: {user: {methods: [:profile_image_url]}}}}, methods: [:image_url])}
  end

  def like_post
    post = Post.find(params[:id])
    if current_user.like_ids.include?(post.id)
      current_user.likes.delete(post)
      render json: {message: 'disliked'}
    else
      current_user.likes << post
      render json: {message: "liked"}
    end
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :service_category_id, :description, :tag_user_ids => [], :item_ids => [])
  end
end
