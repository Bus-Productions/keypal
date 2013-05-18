class CreateOutbounds < ActiveRecord::Migration
  def change
    create_table :outbounds do |t|
      t.string :user_id

      t.timestamps
    end
  end
end
