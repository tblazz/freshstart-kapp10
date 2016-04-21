class ResultMailer < ApplicationMailer

  #Envoi un mail au participant
  def mail_result(name, time, mail_address, image_file_name, image_path)
    if image_path && mail_address
    end
    subject = "Résultat Ahargo Lasterkaz"
    @name = name
    @time = time
    attachments[image_file_name] = File.read(image_path)
    mail to: mail_address, subject: subject do |format|
      format.html { render layout: 'result_mailer' }
      format.text { render layout: 'result_mailer' }
    end
  end

end
