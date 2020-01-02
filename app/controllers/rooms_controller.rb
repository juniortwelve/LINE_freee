class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @myEntries = current_user.entries
    @rooms = []
    @roomIds = []

    @myEntries.each do |myEntry|
      @roomIds << myEntry.room_id
      @rooms << Room.find(myEntry.room_id)
    end

    @anotherEntries = Entry.where(room_id: @roomIds).where.not(user_id: current_user.id)
  end

  def create
    user=User.find(params[:id])
    currentUserEntry=Entry.where(user_id: current_user.id)
    userEntry=Entry.where(user_id: user.id)
    currentUserEntry.each do |cu|
      userEntry.each do |u|
        if cu.room_id == u.room_id
          @isRoom = true
          @room = cu.room
        end
      end
    end

    unless @isRoom
      @room = Room.create
      Entry.create(:room_id => @room.id, :user_id => current_user.id)
      Entry.create(:room_id => @room.id, :user_id => user.id)
    end
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(:user_id => current_user.id, :room_id => @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @user = @room.entries.where.not(user_id: current_user.id).first.user
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
