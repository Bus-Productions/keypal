class AddVerifyCodeToUser < ActiveRecord::Migration
  def change
    add_column :users, :verify_code, :integer
  end
end
