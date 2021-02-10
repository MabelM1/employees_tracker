class WorkOrdersController < ApplicationController
    # skip_before_action :verify_authenticity_token
    def index
        user = User.find(session[:user_id])
        @work_orders = user.work_orders.find_work_order
    end

    def close
        work_order = WorkOrder.find(params[:id]) 
        work_order.update(status: params[:work_order_status])   
        redirect_to user_work_order_path(work_order.user,work_order)
    end

    def show 
        @user = User.find(params[:user_id]) 
        return head(:forbidden) unless session[:user_id].to_s == params[:user_id].to_s || !@user.employees.where("id = ?",session[:employee_id]).empty?
        @work_order = @user.work_orders.find(params[:id])
    end  

    def new
        @employee = Employee.new
        @user = User.find(session[:user_id])
        @work_order = WorkOrder.new
    end

    def create   
        @work_order = WorkOrder.new(work_order_params)
        @user = User.find(session[:user_id])
        if params[:work_order][:employee] && params[:work_order][:building]
          @employee = Employee.find(params[:work_order][:employee])
          @building = Building.find(params[:work_order][:building])
          @work_order.user = @user 
          @work_order.employee = @employee
          @work_order.building = @building
  
          if @work_order.valid? 
            @work_order.save
            redirect_to user_work_order_path(@user,@work_order)
          else
            flash[:error] = @work_order.errors.full_messages 
            redirect_to new_user_work_order_path
          end  
        else
            flash[:error] = ["Please select a date"]
            redirect_to new_user_work_order_path
        end
        

    end

    def edit 
        return head(:forbidden) unless session[:user_id].to_s == params[:user_id].to_s
        @work_order = WorkOrder.find(params[:id])  
        @user = @work_order.user
    end

    def update
       work_order = WorkOrder.find(params[:id])
       work_order.update(work_order_params)
       redirect_to edit_user_work_order_path(work_order.user,work_order)
    end


    private
    def work_order_params
        params.require(:work_order).permit(:task, :date )
    end
end