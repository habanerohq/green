require 'sorbet_pantry'

class Habanero::Observer < Pantry::Observer
  # observe every sorbet
  if Habanero::Sorbet.table_exists?
    observe Habanero::Sorbet.all.map { |s| s.qualified_name.underscore.to_sym } - [:'active_record/base']
    ::SorbetPantry.new.define_stacks
  else
    # todo: don't want to observe anything at this point?
    observe :'habanero/sorbet'
  end

end
