class AddUsersTable < ActiveRecord::Migration[5.0]
	def change
    create_table :users do |t|
      t.string :last_name
      t.string :first_name
      t.string :password
      t.string :email
      t.string :nickname
      t.date :dob
      t.timestamps
    end
	end
end
