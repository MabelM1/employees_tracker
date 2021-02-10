class CommentsController < ApplicationController
    def show 
    #   if session[:user_id].to_s == params[:id].to_s
    #     @user = User.find(params[:id])
    #   else
    #     redirect_to '/sessions/new'
    #   end
    end

    def new
    #    @user = User.new
    end

    def create   
        work_order = WorkOrder.find(params[:work_order_id])
        comment = Comment.new(comment_params)
        if session[:user_id]
          user = User.find(session[:user_id])
          comment.work_order = work_order
          comment.user = user
          comment.save(validate: false)
          redirect_to  user_work_order_path(work_order.user,work_order)
        elsif session[:employee_id]
          employee = Employee.find(session[:employee_id])
          comment.work_order = work_order
          comment.employee = employee
          comment.save(validate: false)
          redirect_to  user_work_order_path(employee.user,work_order)
        end



    end

     private

     def comment_params
       params.require(:comment).permit(:comment, :subject)
     end

end