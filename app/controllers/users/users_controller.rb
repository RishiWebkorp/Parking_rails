class Users::UsersController < ApplicationController

    load_and_authorize_resource

    before_action :get_data, except: %i[index]


    def index
        @users = User.all
        render json: @users
    end

    def show
    
        render json: @user
    end
    

    def update
    
        if @user.update(user_params)
            render json: {message: "User updated successfully."}
        else 
            render json: {message: "User not updated successfully."}
        end

    end

    def destroy
      
        if @user.destroy
            render json: {message: "User deleted successfully."}
        else
            render json: {message: "User not deleted successfully."}
        end
    end

    private

    def get_data
        @user = User.find(params[:id]) 
    end

    def user_params
        params.require(:user).permit(:email, :password, :name, :role, :slot_id)
    end

end