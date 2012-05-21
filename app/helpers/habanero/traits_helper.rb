module Habanero  
  module TraitsHelper
    include ContentHelper
    
    def format_habanero_category_trait(target, trait)
      if v = value_for(target, trait)
        trait_span(trait) do
          v.name
        end
      end
    end

    def format_habanero_currency_trait(target, trait)
      if v = value_for(target, trait)
        trait_span(trait) do
          number_to_currency v, :precision => trait.precision || 2
        end
      end
    end

    def format_habanero_percentage_trait(target, trait)
      if v = target.send(trait.method_name)
        trait_span(trait) do
          number_to_percentage v, :precision => trait.precision || 1
        end
      end
    end

    def format_habanero_range_trait(target, trait)
      trait_span(trait) do
        trait.children.map { |c| target.send(c.method_name) }.join('...')
      end
    end

    def format_habanero_text_trait(target, trait)
      if v = value_for(target, trait)
        trait_span(trait) do
          to_content(@feature, v)
        end
      end
    end

    def format_habanero_true_false_trait(target, trait)
      v = "#{target.send(trait.method_name)}"
      trait_span(trait, :class => v.idify) { v }
    end

    def format_habanero_nest_trait(target, trait)
      trait_span(trait) do 
        v = target.parent
        link_to v, scene_path(@feature.scene, :id => v, :variety_type => trait.variety) if v
      end
    end

    def format_habanero_association_trait(target, trait)
      if trait.relation =~ /many/
        trait_span(trait) do 
          value_for(target, trait).map(&:to_s).join(', ')
        end
      else
        v = value_for(target, trait)
        link_to v, scene_path(@feature.scene, :id => v, :variety_type => trait.inverse_variety) if v
      end
    end

    def format_trait(target, trait)
      method = "format_#{trait.class.name.attrify}"
      if respond_to?(method) && trait.class != Habanero::Trait
        send(method, target, trait)
      else
        trait_span(trait) { "#{value_for(target, trait)}" }
      end
    end
    
    def trait_span(trait, options = {}, &block)
      options[:class] = "#{trait_css_classes(trait)} #{options[:class]}"
      content_tag(:span, options, &block)
    end

    def trait_css_classes(trait)
      "trait #{trait.class.to_s.idify} #{trait.qualified_name.idify}"
    end

    def value_for(target, trait)
      target.send(trait.name.attrify)
    end

    def trait_input_options(trait)
      options = [trait.column_name]
    end
  end
end
