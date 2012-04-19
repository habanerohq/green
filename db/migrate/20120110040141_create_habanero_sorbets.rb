class CreateHabaneroSorbets < ActiveRecord::Migration
  def change
    create_table :habanero_sorbets do |t|
      t.belongs_to :brand
    end
  end
end
