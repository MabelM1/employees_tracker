class CreateBuildings < ActiveRecord::Migration[6.0]
    def change
        create_table :buildings do |t|
          t.string :address
          t.string :super_name
          t.string :phone_number
          t.string :user_id
        end
      end
end
