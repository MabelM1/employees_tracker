class Comment < ApplicationRecord
    belongs_to :work_order
    belongs_to :user
    belongs_to :employee
    has_many :replies

    def date
        self.created_at.strftime("%a %b %d, %Y %I:%M%p")
    end


end
