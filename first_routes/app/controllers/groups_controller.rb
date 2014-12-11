class GroupsController < ApplicationController
  def index
    @groups = Group.where(user_id: params[:user_id])
    render json: @groups
  end
  
  def show
    @group = Group.find(params[:id])
    render json: @group
  end
  
  def contacts
    @group = Group.find(params[:id])
    @contacts = @group.contacts
    render json: @contacts
  end
end