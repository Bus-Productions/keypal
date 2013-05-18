class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.integer :user_id
      t.string :key
      t.string :pass

      t.timestamps
    end
  end
end
