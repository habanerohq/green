namespace :habanero do
  namespace :variety do
    task :use => :environment do
      VarietyPantry.new.use
    end

    task :stack => :environment do
      VarietyPantry.new.stack
    end
  end
end
