class AddCommonFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :full_name, :string
    add_column :users, :gender, :boolean
    add_column :users, :dob, :date
	add_index :users, :full_name
  end
end
