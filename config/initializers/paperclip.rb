Paperclip::Attachment.default_options[:s3_host_name] = "s3-#{ENV["AWS_REGION"]}.amazonaws.com"
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'