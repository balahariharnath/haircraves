class Api::MessagesController < ApplicationController
  load_and_authorize_resource

  def create
    @conversation = Conversation.get(current_user.id, params[:user_id])
    @message = @conversation.messages.create(message_params.merge(sender_id: current_user.id))
    render json: { message: "Success" }
  end

  def conversation_list
    @conversation = Conversation.eager_load(:messages).where("(conversations.sender_id = ? or receiver_id = ?) and messages.id is not null", current_user.id, current_user.id)

    render json: { conversation: @conversation.as_json(include: { :recent_message => {}, sender: {methods: [:profile_image_url]}, receiver: {methods: [:profile_image_url]}})}
  end

  def conversation
    @conversation = Conversation.get(current_user.id, params[:user_id])
    @messages = @conversation.messages
    render json: {messages: @messages.as_json(include: {conversation: {include: { sender: {methods: [:profile_image_url]}, receiver: {methods: [:profile_image_url]}}}})}
  end
  
  def clear_message
    @conversation = Conversation.get(current_user.id, params[:user_id])

    @conversation.messages.destroy_all
    render json: {message: "message cleared"}
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

end