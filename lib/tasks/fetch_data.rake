# lib/tasks/fetch_data.rake

namespace :data do
    desc "Obtener y persistir datos desde el feed de USGS"
    task fetch_data: :environment do
      require 'httparty'
      require 'json'
  
      response = HTTParty.get('https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson')
  
      if response.success?
        data = JSON.parse(response.body)
  
        data['features'].each do |feature_data|
          Feature.create_or_update_from_data(feature_data)
        end
  
        puts "Datos recuperados y guardados exitosamente."
      else
        puts "No se pudieron recuperar los datos del feed de USGS."
      end
    end
  end
  