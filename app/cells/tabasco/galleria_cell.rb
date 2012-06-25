module Tabasco
  class GalleriaCell < Habanero::VarietyCell

    def thumbs(options)
      get_started(options)
      @target = find_target
      @pictures = @target.pictures
      render
    end
  end
end
