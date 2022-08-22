class Api::CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    comment = current_user.comments.new(comment_params)

    if comment.save
      render json: {comment: comment.as_json(include: {post:  {include: {tag_users:
                                      {methods: [:profile_image_url, :cover_image_url]}, items: {methods: [:image_urls, :video_url]}}},
                                                        user: {methods: [:profile_image_url]}})}
    end

  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :message)
  end
end
