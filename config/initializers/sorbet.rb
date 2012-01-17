Habanero.autoload_blacklist = [ 'Habanero::Ingredient', 'Habanero::Namespace', 'Habanero::Sorbet' ]
Module.send :include, Habanero::ConstMissing