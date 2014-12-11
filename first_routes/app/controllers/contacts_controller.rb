class ContactsController < ApplicationController
  
  def index
    @contacts = Contact.where(:user_id => params[:user_id])
    render json: @contacts
  end
  
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: @contact
    else
      render @contact.errors.full_messages, :status => 404
    end
  end
  
  def show
    @contact = Contact.find(params[:id])
    render json: @contact
  end
  
  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      render json: @contact
    else
      render @contact.errors.full_messages, :status => 404
    end
  end
  
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    render json: @contact
  end

  private
  
  def contact_params
    params[:contact].permit(:name, :email, :user_id)
  end
end
