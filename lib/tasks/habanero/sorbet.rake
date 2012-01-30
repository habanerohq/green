namespace :habanero do
  namespace :sorbet do
    task :use => :environment do
      SorbetPantry.new.use
    end

    task :stack => :environment do
      SorbetPantry.new.stack
    end
  end
end
