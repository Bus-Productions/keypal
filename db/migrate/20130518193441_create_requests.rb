class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :from_number
      t.string :body

      t.timestamps
    end
  end
end
