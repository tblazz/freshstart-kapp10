class ResultMailer < ApplicationMailer

  #Envoi un mail au participant
  def mail_result(name, time, sender_mail, race_name, race_name_mail, hash_tag, mail_address, rank, results_url, sms_message, image_file_name, image_path, short_image_path)
    if image_path && mail_address
      subject = I18n.t('mail_subject', race_name_mail: race_name_mail)
      @name = name
      @time = time
      @race_name = race_name
      @race_name_mail = race_name_mail
      @hash_tag = hash_tag
      @url = short_image_path
      @sms_message = sms_message % { name: name, time: time, url: short_image_path, race_name_mail: race_name_mail,rank: rank, results_url: results_url}
      # @path = short_image_path
      response = HTTParty.get(image_path)
      if response
        temp_file = Tempfile.new(SecureRandom.hex(20), "/tmp", :encoding => 'ascii-8bit')
        temp_file.write(response.body)

        attachments[image_file_name] = File.read(temp_file)

        mail to: mail_address, from: I18n.t('mail_sender', sender_mail: sender_mail), subject: subject

        temp_file.unlink
      end
    end
  end

end
