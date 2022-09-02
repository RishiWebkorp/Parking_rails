class ChangesInSlots < ActiveRecord::Migration[7.0]

  def up
    change_column :slots, :car_no, :string
  end

  def down
    change_column :slots, :car_no, :integer 
  end
end
