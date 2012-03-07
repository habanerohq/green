require 'sorbet_pantry'

class Habanero::Observer < Pantry::Observer
  # observe every sorbet
  observe Habanero::Sorbet.all.map { |s| s.qualified_name.underscore.to_sym } - [:'active_record/base']

  ::SorbetPantry.new.define_stacks
end
