class Addfloortoslots < ActiveRecord::Migration[7.0]
  def change
    add_column :slots, :floor, :integer
  end
end
