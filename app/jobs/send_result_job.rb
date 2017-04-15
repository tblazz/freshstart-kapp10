class SendResultJob < ActiveJob::Base
  queue_as :normal

  def perform(result)
    @result = Result.find(result)

    # Envoi du mail
    ResultMailer.mail_result(@result).deliver_later if @result.mail =~ MAIL_REGEX

    # Envoi du SMS
    # @result.sms.send
  end
end