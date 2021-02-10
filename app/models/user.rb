class User < ApplicationRecord
    has_secure_password
    has_many :work_orders
    has_many :employees#, through: :work_orders
    has_many :buildings#, through: :work_orders
    has_many :replies
    
    validates :username, :email, :licence_number,  presence: true
    validates :username, :email, :licence_number, uniqueness: true
    validates_with OldPasswordValidator , :if => :password_required?

  
    
     
    validates :password, :presence =>true, :confirmation =>true , :if => :password_required?
    validates_confirmation_of :password , :if => :password_required?

   def old_password=(password)
     if self.authenticate(password[:old_password])
      @old_password = true
     end
   end

   def old_password
    @old_password
   end
    protected

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

end