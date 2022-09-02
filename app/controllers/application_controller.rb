class ApplicationController < ActionController::API

    before_action :configure_permitted_parameters, if: :devise_controller? 

    def user_admin
        current_user.role == "admin"
    end

    def user_part
        current_user.role == "user"
    end

    # Errors Handling
    rescue_from CanCan::AccessDenied do
        render json: { 'message' => 'User is not authorised for this action!' }, status: 401
    end

    rescue_from ActiveRecord::RecordNotFound do |exception|
        not_found_reponse('record not found!')
        p exception
    end

    rescue_from ActionController::ParameterMissing do |e|
        faliure_response("Wrong Parameters provided.")
    end

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys:[ :email, :password, :name, :role ])
    end
    

    # def booked_status_check
    #     if current_user.status == "Unbooked"
    #         render json: { 'message' => " Slots are available"}
    #     elsif current_user.status == "booked"
    #         render json: {'message' => " Slots are not available"}
    # end

    # def total_slots_check
    #     total_slots = 10
    #     slots[total_slots]
    #     if current_user.status == "unbooked"
    #        slots[total_slots] = slots[total_slots - 1]
    #     end
    # end

end
