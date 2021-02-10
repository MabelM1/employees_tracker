class PayRolesController < ApplicationController
    def index    
        @employee = Employee.find(params[:employee_id])
        @pay_roles = @employee.pay_roles
    end
    def show 
         employee = Employee.find(params[:employee_id])
         user = User.find(params[:user_id])
         @pay_role = PayRole.find(params[:id])
        return head(:forbidden) unless @pay_role.employee.id.to_s == session[:employee_id].to_s || @pay_role.employee.user.id.to_s == session[:user_id].to_s

    end


    def create  
        @employee = Employee.find(session[:employee_id])
        @pay_role = PayRole.new(pay_role_params(:punch_in))
            @pay_role.employee = @employee
            @pay_role.save
            @user = @employee.user
            redirect_to  user_employee_pay_roles_path(@user,@employee)
    end

      def edit
         @pay_role = PayRole.find(params[:id])
        #  return head(:forbidden) unless params[:id].to_s == @pay_role.id || @pay_role.employee.user.id.to_s == session[:user_id].to_s
         @employee = @pay_role.employee
         @user = @employee.user
      end
       
      def update
        pay_role = PayRole.find(params[:id])
        user = User.find(params[:user_id])

        if session[:user_id]
            pay_role.format_convert(pay_role_params(:punch_out_date,:punch_out_time,:punch_in_date,:punch_in_time))
            redirect_to  edit_user_employee_pay_role_path(user,pay_role.employee, pay_role)
        else
            pay_role.update(pay_role_params(:punch_out))
            employee = pay_role.employee
            pay_role.save
            redirect_to  user_employee_pay_roles_path(user,employee)
        end
      end

     private
     def pay_role_params(*args)
		params.require(:punch).permit(*args)
      end
end