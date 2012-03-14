module Habanero
  module ScoopPlacementIce
    extend ActiveSupport::Concern

    def region_name
      region ? region.name.attrify.to_sym : :content
    end

    def query
      scoop.query
    end
    
    def search
      scoop.search
    end
    
    def ingredients
      scoop.ingredients
    end
    
    def prepare_search(params, page)
      if data = params[params_key]
        scoop.translate_search(data)
        page.placements.each { |p| p.scoop.search = scoop.search }
      end
    end
    
    def prepare(*args)
      method = "prepare_#{template.attrify}"
      send(method, *args) if respond_to?(method)
    end
    
    def params_key
      "#{template}_#{id}"
    end

    def to_s
      "#{scoop} # #{template}"
    end
  end
end
