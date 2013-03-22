class RsvpMailer < ActionMailer::Base
  default to: User.all.map(&:email),
          from: "notifier@jerelandliz.com"

  def notify_new_rsvp(rsvp)
    @name = rsvp.name
    @attending = rsvp.attending

    mail subject: "New RSVP!"
  end
end
