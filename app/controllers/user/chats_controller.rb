class User::ChatsController < ApplicationController

  before_action :block_non_related_customers, only: [:show]

  def show
    @customer = Customer.find(params[:id])
    rooms = current_customer.customer_rooms.pluck(:room_id)
    customer_rooms = CustomerRoom.find_by(customer_id: @customer.id, room_id: rooms)
    unless customer_rooms.nil?
      @room = customer_rooms.room
    else
      @room =Room.new
      @room.save
      CustomerRoom.create(customer_id: current_customer.id, room_id: @room.id)
      CustomerRoom.create(customer_id: @customer.id, room_id: @room.id)
    end

    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_customer.chats.new(chat_params)
    render :validate unless @chat.save
  end

  def destroy
    @chat = current_customer.chats.find(params[:id])
    @chat.destroy
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def block_non_related_customers
    customer = Customer.find(params[:id])
    unless current_customer.following?(customer) && customer.following?(current_customer)
      rendirect_to new_customer_registration_path
    end
  end
end