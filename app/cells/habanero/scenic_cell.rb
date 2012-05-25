module Habanero
  class ScenicCell < Habanero::VarietyCell
    include Habanero::ScenesHelper

    def plan(options)
      get_started(options)
      @target = find_target
      @placements = @target.all_placements
      render
    end
  end
end
