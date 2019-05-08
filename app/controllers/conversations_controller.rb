class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @my_bookings = Booking.renting_from_users(current_user)
    @users_bookings = Booking.renting_to_users(current_user)
    # @conversation_exists = Conversation.conversation_exists?(current_user, )
    # @conversation_has_messages = Conversation.conversation_has_messages?
    @conversations = Conversation.all
  end

  def create
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(
        params[:sender_id],
        params[:recipient_id]
      ).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
