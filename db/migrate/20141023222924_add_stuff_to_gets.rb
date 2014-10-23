class AddStuffToGets < ActiveRecord::Migration
  def change
    add_column :gets, :call, :string
    add_column :gets, :user_id, :integer
  end
end
