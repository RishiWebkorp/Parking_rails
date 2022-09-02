class Addslotidtouser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :slot_id, :integer
  end
end
