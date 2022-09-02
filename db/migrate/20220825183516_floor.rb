class Floor < ActiveRecord::Migration[7.0]
  def change
    create_table :floors do |t|
      t.integer :floor

      t.timestamps
    end
  end
end
