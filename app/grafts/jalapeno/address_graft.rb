module Jalapeno
  module AddressGraft
    extend ActiveSupport::Concern
#    include GeoKit::Geocoders

    included do
#      acts_as_mappable :default_units => :kms
#      before_validation :geocode
    end

    def geocode
      geo = MultiGeocoder.geocode(to_s)
      errors.add(:address, 'Could not Geocode address') if !geo.success
      self.success = geo.success
      self.provider = geo.provider
      if geo.success
        [:accuracy, :city, :country, :country_code, :full_address, :lat, :lng, :precision, :province, :state, :zip].each do |method|
          self.send("#{method}=", geo.send(method)) unless geo.send(method).blank?
        end
      end
    end

    def to_s_qual
      [
        property_name,
        to_s
      ].compact.join(', ')
    end
    
    def to_s
      [
        ("#{street_number} #{street_name}" if street_name.present?),
        city,
        "#{state} #{zip}",
        country
      ].compact.join(', ')
    end

    module ClassMethods
      def distance_to_zoom(kilometers)
        14 - Math.log2(kilometers.to_f).floor if kilometers
      end
    end
  end
end
