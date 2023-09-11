require 'uri'
require 'net/http'
require 'json'

class MarsRoverAPI
  BASE_URL = 'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos'
  API_KEY = 'bCQ3uQoJ8FEyOLEF1MUSjcZ1Fz7GBNLpaVfQJhfv' 

  def self.request(url)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def self.build_index_page(photos)
    html = "<html>\n<head>\n</head>\n<body>\n<ul>\n"
    photos[0..24].each do |photo|  # Obtiene las primeras 25 fotos
      html += "<li><img src='#{photo['img_src']}'></li>\n"
    end
    html += "</ul>\n</body>\n</html>"
    File.write('index.html', html)
  end
end

sol_value = 25
url = "#{MarsRoverAPI::BASE_URL}?sol=#{sol_value}&api_key=#{MarsRoverAPI::API_KEY}"

# Realiza la solicitud a la API
response = MarsRoverAPI.request(url)

# Crea el archivo index.html con las primeras 25 fotos
MarsRoverAPI.build_index_page(response['photos'][0..24])
