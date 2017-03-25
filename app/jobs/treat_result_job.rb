require 'csv'

class TreatResultJob < ActiveJob::Base
  queue_as :normal

  def perform(name, rank, time, speed, number, mail, phone_number, race_name, race_date, message, race_detail, sender_mail, race_name_mail, hash_tag, results_url, sms_message_template, root_url)
    #on génère le HTML contenant ces informations
    erb_file = "#{Rails.root}/app/views/result/template.html.erb"
    erb_str = File.read(erb_file)

    @name = name
    @rank = rank
    @time = time
    @speed = speed
    @number = number
    @message = message

    @rank_total = @rank == 1 ? I18n.t('first_suffix') : @rank == 2 ? I18n.t('second_suffix') : I18n.t('third_suffix')
    @race_name = race_name
    @race_date = race_date
    @race_detail = race_detail

    @rank_image = root_url+'template/images/ic_medal.png'
    @time_image = root_url+'template/images/ic_timer.png'
    @speed_image = root_url+'template/images/ic_speed.png'

    renderer = ERB.new(erb_str)
    if renderer
      rendered_html = renderer.result(binding)
      #on convertit le HTML en img
      kit = IMGKit.new(rendered_html, height: IMAGE_HEIGHT, width: IMAGE_WIDTH)
      kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/template.css"
      folder_name = "#{@race_name}_#{@race_date}".gsub('/', '-')
      Rails.logger.info("folder name : #{folder_name}")
      folder_name.gsub!(/\s/, '-')
      folder_name = ActiveSupport::Inflector.transliterate folder_name if folder_name
      image_file_name = folder_name+"_"+@number+".jpg"
      image_path = AWS_ROOT+KAPP10_BUCKET_NAME+"/"+folder_name+"/"+image_file_name
      short_image_path = Bitly.client.shorten(image_path, history: 1).jmp_url

      # SMS
      first_names = @name.strip.split(/\s+/)
      first_name = first_names[0] if first_names.count > 0

      sms_template = sms_message_template.nil? || sms_message_template.eql?("") ? I18n.t('sms_message_template') : sms_message_template

      Rails.logger.info("sms template #{sms_template}")

      #on envoi l'img sur S3
      p KAPP10_FINISHLINE_BUCKET
      complete_image_name = "#{folder_name}/#{image_file_name}"
      p complete_image_name
      p kit
      p kit.to_img(:jpg)
      # KAPP10_FINISHLINE_BUCKET.object(complete_image_name).put(content_type: 'image/jpeg', body: kit.to_img(:jpg))

      #on envoi un mail récapitulatif si le mail est fourni et valide
      p @rank_total
      p @rank
      ResultMailer.mail_result(first_name ? first_name : @name, @time, sender_mail, race_name, race_name_mail, hash_tag, mail, "#{@rank}#{@rank_total}", results_url, sms_template, image_file_name, image_path, short_image_path).deliver_later if mail =~ MAIL_REGEX

      #on envoi un sms et un message Facebook si le numéro de téléphone est valide
      if phone_number =~ PHONE_REGEX
        # SendSmsJob.perform_later(first_name ? first_name : @name, @time, race_name_mail, phone_number, @rank+@rank_total, results_url, sms_template, short_image_path, folder_name)
        # SendMessengerMessageJob.perform_later(first_name ? first_name : @name, @time, race_name_mail, phone_number, image_path)
      end

    end
  end
end