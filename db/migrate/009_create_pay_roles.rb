class CreatePayRoles < ActiveRecord::Migration[6.0]
    def change
      create_table :pay_roles do |t|
        t.datetime :punch_in
        t.datetime :punch_out
        t.string :employee_id
        t.timestamps null: false
      end
    end
  end