module Habanero
  module Autoload
    extend ActiveSupport::Concern

    included do
      alias_method_chain :autoload_module!, :sorbet
    end

    def autoload_module_with_sorbet!(*args)
      into, const_name, qualified_name = *args

      mod = nil

      unless qualified_name =~ /^Habanero::Sorbet::/
        # don't spam console and log with sql when missing constants are accessed
        ActiveRecord::Base.logger.silence do
          mod = Habanero::Sorbet.namespaced(into.to_s).where(:name => const_name).first.try(:chill!) ||
                Habanero::Namespace.where(:name => qualified_name).first.try(:chill!)
        end
      end

      mod || autoload_module_without_sorbet!(*args)
    end
  end
end
