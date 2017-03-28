include Rails.application.routes.url_helpers

class GenerateDiploma

  def initialize(result, template='template1')
    @result = (result.class == String) ? Result.find(result) : result
    @template = template
    @name = @result.name
    @rank = @result.rank
    @time = @result.time
    @speed = @result.speed
    @number = @result.bib
    @message = @result.message
    @rank_total = @result.rank_total
    @race_name = @result.race.name
    @race_date = I18n.l @result.race.date
    @race_detail = @result.race_detail
    @background_image_url = @result.race.background_image.url(:standard)
  end

  def html
    return @html if @html
    #on génère le HTML contenant ces informations
    erb_file = "#{Rails.root}/app/views/diploma/#{@template}.html.erb"
    erb_str = File.read(erb_file)
    renderer = ERB.new(erb_str)
    return nil unless renderer
    renderer.result(binding)
  end

  def image_kit(height, width)
    kit = IMGKit.new(html, height: IMAGE_HEIGHT, width: IMAGE_WIDTH)
    kit
  end
end