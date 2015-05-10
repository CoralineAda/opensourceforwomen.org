class ContactsController < ApplicationController

  def new
    @contact = Contact.new(email: current_user && current_user.email || "")
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.email = current_user && current_user.email || ""
    if @contact.save
      ContactMailer.contact_form_email(@contact.to_json).deliver_later
      flash.notice = 'Thank you for your message. We will reply as soon as possible.'
      redirect_to root_path
    else
      flash.now[:error] = 'Sorry! We were unable to send your message.'
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :name, :message)
  end

end