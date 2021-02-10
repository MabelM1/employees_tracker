class SessionsController < ApplicationController

    def create 
        @user = User.find_by(username: params[:user][:username])
        @employee = Employee.find_by(email: params[:user][:username])
        if @user
            return redirect_to '/sessions/new' unless @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        elsif @employee
            return redirect_to '/sessions/new' unless @employee.authenticate(params[:user][:password])
            session[:employee_id] = @employee.id
            redirect_to user_employee_path(@employee.user, @employee)
        else
            redirect_to '/sessions/new'
        end  
    end
    
    def fb_login
        @employee = Employee.find_by(email: auth['info']['email']) 
        if @employee
            @employee.update(name: auth['info']['name'], image: auth['info']['image'])
             session[:employee_id] = @employee.id
             redirect_to user_employee_path(@employee.user, @employee)
        else
           flash[:error] = "Couldn't find your account"
           flash[:message] =  "There's no account for that email. Try logging in with a different email."
           redirect_to '/sessions/new'
        end
    end
     
    def destroy
        session.clear
        redirect_to '/'
    end
     

      private

      def auth
        request.env['omniauth.auth']
      end
end
