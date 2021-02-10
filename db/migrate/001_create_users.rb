class CreateUsers < ActiveRecord::Migration[6.0]
    def change
      create_table :users do |t|
        t.string  :address
        t.string  :company_name
        t.string :username
        t.string  :password_digest
        t.string :licence_number
        t.string :country
        t.string :state
        t.string :email
        t.string :phone_number
        t.string :about_us
        t.timestamps
      end
    end
  end