class ResultMailer < ApplicationMailer

  #Envoi un mail au participant
  def mail_result(result)
    Rails.logger.debug 'bite'
    @result = Result.find(result)
    Rails.logger.debug(@result)

    if @result.diploma_url && @result.mail
      subject = I18n.t('mail_subject', race_name_mail: @result.race.email_name)
      mail to: @result.mail, from: I18n.t('mail_sender', sender_mail: @result.race.email_sender), subject: subject
    end
  end

end
