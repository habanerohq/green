module Habanero
  module ConstMissing
    extend ActiveSupport::Concern
    
    included do
      alias_method_chain :const_missing, :sorbet
    end
    
    def const_missing_with_sorbet(*args)
      const_name = args.first.to_s

      begin
        const_missing_without_sorbet(*args) # give rails a chance to autoload files
      rescue NameError => e
        unless Habanero.autoload_blacklist.include?(name)
          klass_name = (name == 'Object' ? const_name : "#{name}::#{const_name}")
          if e.missing_name?(klass_name)
            if sorbet = Habanero::Sorbet.namespaced(name.to_s).where(:name => const_name).first
              return sorbet.chill!
            elsif namespace = Habanero::Namespace.where(:name => klass_name).first
              return namespace.chill!
            end
          end
        end

        raise
      end
    end

  end
end