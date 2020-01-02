class RelationshipsController < ApplicationController
  def index
    @users = User.search(params[:search]).where.not(:id => current_user)
    @sendingIds = []
    @receivedIds = []
    @friendIds = []
    Relationship.where(from_user_id: current_user.id, approval: false).each do |s|
      @sendingIds<< s.to_user_id
    end
    Relationship.where(to_user_id: current_user.id, approval: false).each do |r|
      @receivedIds<< r.from_user_id
    end
    Relationship.where(from_user_id: current_user.id, approval: true).each do |f|
      @friendIds<< f.to_user_id
    end
    Relationship.where(to_user_id: current_user.id, approval: true).each do |f|
      @friendIds<< f.from_user_id
    end
  end

  def create
    relationship = Relationship.new(relationship_params)
    opponent = User.find(params[:relationship][:to_user_id])
    if relationship.save
      redirect_to relationships_url, notice: "#{opponent.name}さんに友だち申請を送りました"
    else
      flash.now[:error] = '#{opponent.name}さんには、既に友だち申請を送っています'
      render :index
    end
  end

  def update
    relationship = Relationship.where(from_user_id: params[:id], to_user_id: current_user.id, approval: false).first
    relationship.update(approval: true)
    redirect_to users_url, notice: "#{User.find(params[:id]).name}さんと友だちになりました"
  end

  def destroy
    relationship = Relationship.where(from_user_id: params[:id], to_user_id: current_user.id, approval: false).first
    relationship.delete
    redirect_to users_url, notice: "#{User.find(params[:id]).name}さんからの承認を拒否しました"
  end

  private
  def relationship_params
    params.require(:relationship).permit(:from_user_id, :to_user_id)
  end
end
