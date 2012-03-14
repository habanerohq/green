module Kaminari
  module Helpers
    class Tag
      def to_s(locals = {}) #:nodoc:
        @template.render :partial => "../views/kaminari/#{@theme}#{self.class.name.demodulize.underscore}", :locals => @options.merge(locals)
      end
    end
  end
end
