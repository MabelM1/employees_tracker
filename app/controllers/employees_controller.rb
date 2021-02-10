class EmployeesController < ApplicationController
    # include ActiveModel::Validations
    
    def index
        if session[:user_id].to_s == params[:user_id].to_s
            @user = User.find(params[:user_id])
            @employees = @user.employees.find_employees
        elsif session[:employee_id]
            employee = Employee.find(session[:employee_id])
            @employees = employee.user.employees.find_employees
        else
            head(:forbidden)
        end
    end

    def edit 
        @employee = Employee.find(params[:id])
        @user = @employee.user
        return head(:forbidden) unless params[:id].to_s == session[:employee_id].to_s || session[:user_id].to_s == @user.id.to_s 
    end

    def update
        employee = Employee.find(params[:id])
        if employee
          if employee.update(employee_params)
           flash[:notice] = "Succesful updated"
          else
            flash[:error] = employee.errors.full_messages 
          end
        end
        redirect_to edit_user_employee_path(employee.user,employee)
    end

    def new
        @user =  User.find(session[:user_id])
        @employee = Employee.new
    end

    def create  
        @user = User.find(session[:user_id])
        @employee = Employee.new(employee_params)
        @employee.user = @user 
        if @employee.valid? 
          @employee.save
          redirect_to user_employee_path(@user,@employee)
        else
          flash[:error] = @employee.errors.full_messages 
          redirect_to new_user_employee_path
        end  
    end

    def show
       return head(:forbidden) unless session[:user_id].to_s == params[:user_id].to_s || session[:employee_id]
        @user = User.find(params[:user_id])
        @employee = @user.employees.find(params[:id])
    end
    
    private
    def employee_params
        params.require(:employee).permit(:name, :password, :date_of_birth, :email, :password_confirmation)
    end
end


