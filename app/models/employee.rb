# require_relative '../validators/employee_validator'

class Employee < ApplicationRecord
    has_secure_password
    belongs_to :user
    has_many :work_orders
    has_many :pay_roles
    has_many :replies
    has_many :comments
    has_many :buildings, through: :work_orders

    validates :name, :email, :date_of_birth, presence: true
    validates  :email,  uniqueness: true

    validates :password, :presence =>true, :confirmation =>true , :if => :password_required?
    validates_confirmation_of :password , :if => :password_required?
    
    scope :find_employees, ->{ order(:name) }
    protected


    def password_required?
      !persisted? || !password.nil? || !password_confirmation.nil?
    end
end


