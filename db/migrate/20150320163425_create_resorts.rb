class CreateResorts < ActiveRecord::Migration
  def change
    create_table :resorts do |t|
      t.text :name
      t.float :latitude
      t.float :longitude
      t.text :state

      t.timestamps null: false
    end
  end
end
