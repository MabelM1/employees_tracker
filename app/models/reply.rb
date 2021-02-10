class Reply < ApplicationRecord
    
    belongs_to :comment
    belongs_to :employee
    belongs_to :user
    
    def date   
        self.created_at.strftime("%a %b %d, %Y %I:%M%p")
    end

end
