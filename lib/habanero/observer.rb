require 'variety_pantry'

class Habanero::Observer < Pantry::Observer
  observe Habanero::Variety.all.map { |s| s.qualified_name.underscore.to_sym } - [:'active_record/base']

  def define_stacks
    ::VarietyPantry.new.define_stacks
    ::HabaneroSitePantry.new.define_stacks
  end
end
