class ToTeamResultMailer < ApplicationMailer
  def mail_original_diploma(result_id, address, postal_code, city, country)
    @result = Result.find(result_id)
    @address = address
    @postal_code = postal_code
    @city = city
    @country = country

    return unless @result.diploma? && @result.mail && @result.purchased_at?

    subject = I18n.t('mail_to_team_original_diploma_subject', edition_name_mail: @result.edition.event.name)

    mail to: I18n.t('mail_sender', sender_mail: @result.race.email_sender), from: I18n.t('mail_sender', sender_mail: @result.race.email_sender), subject: subject
  end
end
