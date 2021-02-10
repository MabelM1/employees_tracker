class RepliesController < ApplicationController
    def show 

    end

    def new
      
       @comment = Comment.find(params[:comment_id])
      

    end

    def create   
      @reply = Reply.new(reply_params)
      comment = Comment.find(params[:comment_id])
      if session[:user_id]
        user = User.find(session[:user_id])
        @reply.user = user
        @reply.comment = comment
        @reply.save(validate: false)
        redirect_to  user_work_order_path(user,comment.work_order)
      elsif session[:employee_id]
        employee = Employee.find(session[:employee_id])
        @reply.employee = employee
        @reply.comment = comment
        @reply.save(validate: false)
        redirect_to  user_work_order_path(employee.user,comment.work_order)
      end

    end

     private
     def reply_params
       params.require(:reply).permit(:reply)
     end
end