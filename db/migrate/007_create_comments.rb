class CreateComments < ActiveRecord::Migration[6.0]
    def change
      create_table :comments do |t|
        t.string :work_order_id
        t.string :employee_id
        t.string :user_id
        t.string :subject
        t.string :comment

        t.timestamps null: false
      end
    end
  end