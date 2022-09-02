class Changesinslots < ActiveRecord::Migration[7.0]

  def up
    change_column :slots, :intime, :datetime
  end

  def down
    change_column :slots, :outtime, :time
  end
end
