module Habanero
  class Search
    attr_accessor :parameters, :translators, :grader_chain

    def initialize(a = {}, t = [])
      @parameters = a
      @translators = t
    end
    
    def translate(chain)
      @grader_chain = to_conditions.reduce(chain) { |result, c| c.apply_to(result) }
    end
    
    def to_conditions
      translators.map { |t| t.to_conditions(parameters) }.flatten.compact
    end

    def method_missing(method_id, *args, &block)
      if method_id.to_s.last == '='
        key = method_id[0..-1].to_sym
        self.class.send :define_method, key do
          parameters[key] = args
        end
        self.send(key)

      else
        self.class.send :define_method, method_id do
          parameters[method_id] if parameters.present?
        end
        self.send(method_id)
      end
    end
  end
end
