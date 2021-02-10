class CreateWorkOrders < ActiveRecord::Migration[6.0]
    def change
        create_table :work_orders do |t|
          t.string :task
          t.string :comment
          t.string :phone_number  
          t.datetime :date
          t.integer :user_id
          t.integer :building_id
          t.integer :employee_id
          t.timestamps
        end
      end
end
