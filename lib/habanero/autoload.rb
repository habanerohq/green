module Habanero
  module Autoload
    extend self

    module ModuleConstMissing
      def self.append_features(base)
        super

        base.class_eval do
          return if respond_to?(:const_missing_without_sorbet)
          alias_method :const_missing_without_sorbet, :const_missing
          alias_method :const_missing, :const_missing_with_sorbet
        end
      end

      def self.exclude_from(base)
        base.class_eval do
          alias_method :const_missing, :const_missing_without_sorbet
          remove_method :const_missing_without_sorbet
        end
      end

      def const_missing_with_sorbet(*args)
        const_name = args.first
        qualified_name = ActiveSupport::Dependencies.qualified_name_for(self, const_name)

        begin
          return const_missing_without_sorbet(*args)
        rescue NameError => e
        end

        mod = self.name != 'Object' && Habanero::Sorbet.namespaced(self.name).where(:name => const_name).first.try(:chill!) ||
              Habanero::Namespace.where(:name => qualified_name).first.try(:chill!)

        return mod if mod

        raise NameError,
              "uninitialized constant #{qualified_name}",
              caller.reject {|l| l.starts_with? __FILE__ }
      end

    end

    def hook!
      Module.class_eval { include ModuleConstMissing }
    end

    def unhook!
      ModuleConstMissing.exclude_from(Module)
    end
  end
end

Habanero::Autoload.hook!
