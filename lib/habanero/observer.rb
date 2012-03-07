require 'sorbet_pantry'

class Habanero::Observer < Pantry::Observer
  observe Habanero::Sorbet.all.map { |s| s.qualified_name.underscore.to_sym } - [:'active_record/base']

  def define_stacks
    ::SorbetPantry.new.define_stacks
  end
end
