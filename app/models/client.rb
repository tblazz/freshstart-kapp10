class Client < ApplicationRecord
  # Validation
  validates :name, presence: true

  def widget_storage_name
    "clients/#{self.name}/#{self.id}"
  end

  def widget_url
    "https://s3-eu-west-1.amazonaws.com/results-widget.kapp10.com/#{widget_storage_name}"
  end

  def widget_gist
    %(
	<iframe class='kapp10-embed' src="//s3-eu-west-1.amazonaws.com/results-widget.kapp10.com/#{widget_storage_name}" frameborder="0" scrolling="no" frameborder="0" allowfullscreen="" style="border: none; width: 1px; min-width: 100%; *width: 100%; height: 100%; min-height: 1100px;" scrolling="no"></iframe>)
  end
end
