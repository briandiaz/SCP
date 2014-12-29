class NotificationsMailer < ActionMailer::Base
  default from: "contact@scpweb.herokuapp.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications_mailer.notifications.subject
  #
  def notifications(user)
    person = Person.find(user.person_id)
    identity = Identity.find(user.uid)
    @person_name = "#{person.first_name} #{person.last_name}"
    @person_username = identity.username
    @person_password = identity.password
    mail to: person.email, subject: "Bienvenido a SCP"
  end
  
  def new_client(person)
    client = Client.where(person_id: person.id)
    @person_name = "#{person.first_name} #{person.last_name}"
    mail to: person.email, subject: "Bienvenido a SCP " + @person_name
  end
end
