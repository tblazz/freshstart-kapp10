class ResultMailer < ApplicationMailer

  #Envoi un mail au participant
  def mail_result(name, time, mail_address, image_file_name, image_path)
    if image_path && mail_address
      subject = "Résultat Ahargo Lasterkaz"
      @name = name
      @time = time
      response = HTTParty.get(image_path)
      if response
        temp_file = Tempfile.new(SecureRandom.hex(20), "/tmp",:encoding => 'ascii-8bit')
        temp_file.write(response.body)

        attachments[image_file_name] = File.read(temp_file)

        mail to: mail_address, subject: subject do |format|
          format.html { render layout: 'result_mailer' }
          format.text { render layout: 'result_mailer' }
        end

        temp_file.unlink
      end
    end
  end

end
