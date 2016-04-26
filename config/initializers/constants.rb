#Liste de constantes utilisées sur l'app
REDIS_URL_VAR = "REDIS_URL"

#CSV
CSV_EXTENSION = ".csv"
CSV_SEPARATOR = ";"
IMAGE_HEIGHT = 1024
IMAGE_WIDTH = 1024

#mail
SENDER_MAIL = "\"Ahargo Lasterkaz & Kapp10\" <contact@kapp10.com>"
MAIL_REGEX = /^.+@.+$/
PHONE_REGEX = /^(((\+?\s?\d{2}\s?\d)|(0\d))\s?\d{2}\s?\d{2}\s?\d{2}\s?\d{2})?$/

SMS_MAX_NAME_LENGHT = 15
SMS_LENGHT = 160

#AWS
AWS_ROOT = "http://s3-eu-west-1.amazonaws.com/"
KAPP10_BUCKET_NAME = ENV['S3_BUCKET']
KAPP10_BUCKET_ROOT = AWS_ROOT + KAPP10_BUCKET_NAME+ "/"

#SMS
SMS_LOGIN = ENV['ALLMYSMS_LOGIN']
SMS_API_KEY = ENV['ALLMYSMS_API_KEY']
SENDER_SMS = 'Kapp10'
SMS_PATH = 'https://api.allmysms.com/http/9.0/sendSms/'

#URL shortener
BITLY_LOGIN = ENV['BITLY_LOGIN']
BITLY_API_KEY = ENV['BITLY_API_KEY']

