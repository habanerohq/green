Rails.application.routes.draw do
  devise_for :users, :class_name => "Jalapeno::User"

  if Habanero::Variety.table_exists? and Habanero::Variety.find_by_name('SignpostTrait')
    Habanero::SignpostTrait.all.each { |i| i.variety.klass.label_signposts(self) }
  end

  namespace :habanero do
    match '/scenes/sort' => 'scenes#sort', :via => :put
  end
  
end
