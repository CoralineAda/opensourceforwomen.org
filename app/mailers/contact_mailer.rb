class ContactMailer < ApplicationMailer

  def contact_form_email(contact_json)
    @contact = Contact.new(JSON.parse(contact_json))
    mail(to: ENV['ADMIN_EMAIL'], subject: "OS4W: Contact Form")
  end

end