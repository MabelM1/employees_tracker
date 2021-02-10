class BuildingsController < ApplicationController
    def show
        return head(:forbidden) unless session[:user_id].to_s == params[:user_id].to_s      
        @building = Building.find(params[:id])
        @user = @building.user

    end

    def index 
        @user = User.find(session[:user_id])
        @building =  @user.buildings
    end
    
    def new
        @user =  User.find(session[:user_id])
        @building = Building.new    
    end
    def create
        @user = User.find(session[:user_id])
        @building = Building.new(employee_params)
        @building.user = @user 
        if @building.valid? 
          @building.save
          redirect_to user_building_path(@user,@building)
        else
          flash[:error] = @building.errors.full_messages 
          redirect_to new_user_building_path
        end  
    end
    def edit
        return head(:forbidden) unless session[:user_id].to_s == params[:user_id].to_s
        @building = Building.find(params[:id])
        @user = @building.user
        
    end
    def update
        building = Building.find(params[:id])
        building.update(employee_params)
        redirect_to edit_user_building_path(building.user,building)
    end

    private
    def employee_params
        params.require(:building).permit(:address, :super_name, :phone_number)
    end


   
end