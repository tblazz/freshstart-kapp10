class ResultMailer < ApplicationMailer

  #Envoi un mail au participant
  def mail_result(name, time, mail_address, image_file_name, image_path)
    if image_path && mail_address
    end
    subject = "Résultat Ahargo Lasterkaz"
    @name = name
    @time = time
    response = HTTParty.get(URI(image_path))
    if response
      attachments[image_file_name] = response.body
      mail to: mail_address, subject: subject do |format|
        format.html { render layout: 'result_mailer' }
        format.text { render layout: 'result_mailer' }
      end
    end
  end

end
