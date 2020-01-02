class UsersController < ApplicationController
  before_action :authenticate_user!, :only => [:show]

  def index
    if user_signed_in?
      @users=User.where.not(:id => current_user.id)
      sendingIds = []
      receivedIds = []
      friendIds = []
      @sendings = []
      @receiveds = []
      @friends = []
      Relationship.where(from_user_id: current_user.id, approval: false).each do |s|
        sendingIds<< s.to_user_id
      end
      Relationship.where(to_user_id: current_user.id, approval: false).each do |r|
        receivedIds<< r.from_user_id
      end
      Relationship.where(from_user_id: current_user.id, approval: true).each do |f|
        friendIds<< f.to_user_id
      end
      Relationship.where(to_user_id: current_user.id, approval: true).each do |f|
        friendIds<< f.from_user_id
      end

      sendingIds.each do |id|
        @sendings << User.find(id)
      end
      receivedIds.each do |id|
        @receiveds << User.find(id)
      end
      friendIds.each do |id|
        @friends << User.find(id)
      end
    end
  end

  def show
    @user=User.find(params[:id])
    currentUserEntry=Entry.where(user_id: current_user.id)
    userEntry=Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      currentUserEntry.each do |cu|
        userEntry.each do |u|
          if cu.room_id == u.room_id
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end

      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :remember_digest)
  end
end