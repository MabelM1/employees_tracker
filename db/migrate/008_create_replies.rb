class CreateReplies < ActiveRecord::Migration[6.0]
    def change
      create_table :replies do |t|
        t.string :reply
        t.string :user_id
        t.string :employee_id
        t.string :comment_id
        t.timestamps
      end
    end
  end