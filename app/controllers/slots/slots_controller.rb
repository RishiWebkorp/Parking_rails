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

            if @slot.outtime == nil
                cal_outtime
                @slot.update(slot_params)   
                #UserMailer.with(outtime:@slot.outtime, status:@slot.status, Price:@slot.Price).outtime.deliver_later
                # slot_payment(@slot.Price)
                render json:{message: "Slots is unbooked and your Amount is #{@slot.Price} "}
            else
                render json:{message: "Slot already Updated"}
                
            end
        else
                render json:{message: "Slots is not updated successfully. #{@slot.errors.full_messages}"}
        end
    end

    def create
        @slot = Slot.new(slot_params)
        if params[:slot][:slot].to_i <= 5

            if @slot.user_id == nil 
                @slot.user_id = current_user.id
                cal_intime
                
                if @slot.save
                    #UserMailer.with(slot:@slot.slot, car_no:@slot.car_no, intime:@slot.intime, name:@slot.name, status:@slot.status).check.deliver_later
                    render json:{message:"Slot is booked on slot number: #{@slot.slot} and car_no: #{@slot.car_no} and Intime is: #{@slot.intime}"}
                else
                    render json:{message:"Slot is not booked.#{@slot.errors.full_messages}" }
                end
            else
                render json:{message:"Already booked with #{@slot.car_no}"}
            end
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