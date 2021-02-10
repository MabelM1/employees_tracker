class UsersController < ApplicationController
  # before_filter :skip_password_attribute, only: :update
    # before_action :set_user, only: [:edit, :update]
      def home
        @user = User.all.first 
      end

      def show 
        if session[:user_id].to_s == params[:id].to_s
          @user = User.find(params[:id])
        else
          redirect_to '/sessions/new'
        end
      end
  
      def new
         @user = User.new
      end
  
      def create  
        @user = User.new(user_params)
        if @user.valid?
          @user.save
          redirect_to '/sessions/new'
        else
            flash[:error] = @user.errors.full_messages 
            redirect_to "/users/new"
        end  
      end

      def edit
        return head(:forbidden) unless params[:id].to_s == session[:user_id].to_s
        @user = User.find(params[:id])
      end

      def update_password 
        user = User.find(params[:id])  
        user.old_password = old_password_params(:old_password)
        if user.valid? && user.update(user_params)  
          session.clear
          redirect_to "/"
        else
          flash[:error] = user.errors.full_messages 
          redirect_to edit_user_path(user)
        end   
        
      end

      def update 
        user = User.find(params[:id])  
          user_params.each{|k,v| user[k] = v
            if user.valid?
              user.save
            else
              flash[:error] = user.errors.full_messages 
            end
          }
        redirect_to  edit_user_path(user)

      end
  
      private
      def old_password_params(*arg)
        params.require(:user).permit(*arg)
      end
         

      def user_params
		    params.require(:user).permit(:company_name, :password, :password_confirmation, :username, :email, :licence_number, :country, :state, :phone_number, :about_us, :address)
      end
  
end

