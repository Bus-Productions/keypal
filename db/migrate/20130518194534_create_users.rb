class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :active
      t.integer :level
      t.string :number
      t.string :stripe_unique

      t.timestamps
    end
  end
end
