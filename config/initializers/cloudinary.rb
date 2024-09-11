require_relative "../../config/environment"

if ENV["CLOUDINARY_URL"].present?
  uri = URI.parse(ENV["CLOUDINARY_URL"])
  puts "Cloudinary URL: #{ENV["CLOUDINARY_URL"]}"


  Cloudinary.config do |config|
    config.cloud_name = uri.host
    config.api_key = uri.user
    config.api_secret = uri.password
  end
else
  Rails.logger.warn("CLOUDINARY_URL não está configurado. Certifique-se de defini-la no seu arquivo .env ou em outra configuração de ambiente.")
end
