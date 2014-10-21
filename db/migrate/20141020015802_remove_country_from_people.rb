class RemoveCountryFromPeople < ActiveRecord::Migration
  def change
    remove_column :people, :country, :string
  end
end
