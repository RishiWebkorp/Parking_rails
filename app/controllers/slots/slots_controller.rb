class Slots::SlotsController < ApplicationController

    
    load_and_authorize_resource

    include Slots::SlotsModule
    
     before_action :slot_id, only: [:show, :update, :destroy]

    def index
        @slots = Slot.all
        render json: @slots
    
    end

    def show
        render json: @slot
    end

    def update
        if @slot.update(slot_params)
            update_details
        else
                render json:{message: "Slots is not updated successfully. #{@slot.errors.full_messages}"}
        end
    end

    def create
        @slot = Slot.new(slot_params)
        if params[:slot][:slot].to_i <= 5
           check_details
        else
            render json:{message:"slot limit exceeded can't create a new slot"}
        end
    end

    def destroy                         
        if @slot.destroy
            render json:{message: 'Slots destroyed successfully'}
        else
            render json:{message: 'Slots is not destroyed successfully'}
        end
    end



    private

    def slot_id
        @slot = Slot.find(params[:id])
    end

    def slot_params
        params.require(:slot).permit(:slot, :car_no, :car_color, :intime, :outtime, :Price, :name,:status, :floor_id, :user_id)

    end
    
   



end 