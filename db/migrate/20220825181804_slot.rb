class Slot < ActiveRecord::Migration[7.0]
  def change
    create_table :slots do |t|
      t.integer :slot
      t.integer :car_no
      t.string  :car_color
      t.time :intime
      t.time :outtime
      t.integer :Price
      t.string :name
      t.string :status

      t.timestamps
    end
  end
end
