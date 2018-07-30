Paperclip::Attachment.default_options[:s3_host_name] = "s3.amazonaws.com"
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'

require 'paperclip/media_type_spoof_detector'

module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end

    def type_from_file_command
      begin
        Paperclip.run("file", "-b --mime :file", :file => @file.path)
      rescue

      end
    end
  end
end
