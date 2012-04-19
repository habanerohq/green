class CreateHabaneroVarieties < ActiveRecord::Migration
  def change
    create_table :habanero_varieties do |t|
      t.belongs_to :brand
    end
  end
end
