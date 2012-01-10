class CreateHabaneroSorbets < ActiveRecord::Migration
  def change
    create_table :habanero_sorbets do |t|
      t.belongs_to :namespace
    end
  end
end
