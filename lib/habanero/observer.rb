require 'sorbet_pantry'

class Habanero::Observer < Pantry::Observer
  # observe every sorbet
  if Habanero::Sorbet.table_exists?
    observe Habanero::Sorbet.all.map { |s| s.qualified_name.underscore.to_sym } - [:'active_record/base']
  end

  ::SorbetPantry.new.define_stacks
end
