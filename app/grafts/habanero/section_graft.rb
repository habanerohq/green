module Habanero
  module SectionGraft
    extend ActiveSupport::Concern

    included do
      validates :name, :presence => true
    end    

    module ClassMethods
      def indexed_roots
        roots.select { |r| r.index_page.present? }
      end
    end    

    def nearest_target
      target || parent.try(:nearest_target)
    end

    def names_idified
      self_and_ancestors.map{ |a| a.name.idify }.join(' ')
    end
    
    def index_page
      page
    end
    
    def page
      pages.detect { |p| p.is_index_page? }
    end
    
    def indexed_children
      children.select { |c| c.index_page.present? }
    end
  end
end
