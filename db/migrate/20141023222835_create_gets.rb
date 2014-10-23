class CreateGets < ActiveRecord::Migration
  def change
    create_table :gets do |t|

      t.timestamps
    end
  end
end
