class Building < ApplicationRecord
     belongs_to :user
     has_many :work_orders
     has_many :employees, through: :work_orders

     validates :super_name, :address, :phone_number, presence: true
     validates :address, uniqueness: true

end
