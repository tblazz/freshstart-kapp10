class SendResultJob < ActiveJob::Base
  queue_as :normal

  def perform(result)
    @result = Result.find(result)

    # Envoi du mail
    ResultMailer.mail_result(@result).deliver_later if @result.mail =~ MAIL_REGEX && @result.sms_sent_at.nil?

    # Envoi du SMS
    @result.sms.send unless @result.sms_sent_at
  end
end