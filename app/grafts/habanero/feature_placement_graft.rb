module Habanero
  module FeaturePlacementGraft
    extend ActiveSupport::Concern

    def bed_name
      bed ? bed.name.attrify.to_sym : :content
    end

    def grader
      feature.grader
    end

    def search
      feature.search
    end

    def traits
      feature.traits
    end

   def prepare_search(params, scene)
      if data = params[params_key]
        feature.translate_search(data)
        scene.all_placements.each { |p| p.feature.search = feature.search if p.feature.id == feature.id }
      end
    end

    def prepare(*args)
      method = "prepare_#{template.try(:attrify) || 'show'}"
      send(method, *args) if respond_to?(method)
    end

    def params_key
      "#{template}_#{id}"
    end

    def to_s
      "#{template} on #{scene}"
    end
  end
end
