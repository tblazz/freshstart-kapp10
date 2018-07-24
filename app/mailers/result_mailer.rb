class ResultMailer < ApplicationMailer

  #Envoi un mail au participant
  def mail_result(result)
    @result = Result.find(result)
    return unless @result.diploma? && @result.mail

    subject = I18n.t('mail_subject', edition_name_mail: @result.edition.event.name)
    mail to: @result.mail, from: I18n.t('mail_sender', sender_mail: @result.race.email_sender), subject: subject
    @result.update_attribute(:email_sent_at, Time.now)
  end

end
