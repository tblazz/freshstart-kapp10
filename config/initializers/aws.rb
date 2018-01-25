Aws.config.update({
                      region: ENV['AWS_REGION'],
                      credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
                  })

AWS_RESOURCE = Aws::S3::Resource.new

KAPP10_FINISHLINE_BUCKET = AWS_RESOURCE.bucket(ENV['S3_BUCKET'])
KAPP10_WIDGETS_BUCKET = AWS_RESOURCE.bucket(ENV['S3_WIDGET_BUCKET'])
