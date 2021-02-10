class WorkOrder < ApplicationRecord
    belongs_to :building
    belongs_to :employee
    belongs_to :user
    has_many :comments
   

    scope :find_work_order, ->{ order(:date) }

    validates :task, :date,  presence: true
    # validates :ss, :email, :password_digest, uniqueness: true
    def date_format
         self.date.strftime("%A %m-%d-%Y")
    end

    def tasks
        task.strip.split(/\.|\,/)
    end 

end