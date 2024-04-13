# app/models/feature.rb

class Feature < ApplicationRecord
    validates :title, :url, :place, :mag_type, :longitude, :latitude, presence: true
    validates :magnitude, inclusion: { in: -1.0..10.0 }
    validates :longitude, :latitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  
    def self.create_or_update_from_data(data)
      feature = find_or_initialize_by(id: data['id'])
      feature.update(
        magnitude: data['properties']['mag'],
        place: data['properties']['place'],
        time: Time.at(data['properties']['time'] / 1000),
        url: data['properties']['url'],
        tsunami: data['properties']['tsunami'],
        mag_type: data['properties']['magType'],
        title: data['properties']['title'],
        longitude: data['geometry']['coordinates'][0],
        latitude: data['geometry']['coordinates'][1]
      )
      feature.save if feature.valid?
    end
  end
  