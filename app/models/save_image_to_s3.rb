class SaveImageToS3
  def initialize(race_name,race_date,bib, image)
    @image = image
    @folder_name = "#{race_name}_#{I18n.l(race_date)}".gsub('/', '-')
    @folder_name.gsub!(/\s/, '-')
    @folder_name = ActiveSupport::Inflector.transliterate @folder_name if @folder_name
    @image_file_name = "#{@folder_name}_#{bib}.jpg"
    @image_path = AWS_ROOT+KAPP10_BUCKET_NAME+"/"+@folder_name+"/"+@image_file_name
  end

  def call
    #on envoi l'img sur S3
    complete_image_name = "#{@folder_name}/#{@image_file_name}"
    KAPP10_FINISHLINE_BUCKET.object(complete_image_name).put(content_type: 'image/jpeg', body: @image, acl:'public-read')
    { image_path: @image_path,
      image_file_name: @image_file_name,
      folder_name: @folder_name
    }
  end
end