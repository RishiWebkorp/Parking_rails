class Slots::SlotsController < ApplicationController
    load_and_authorize_resource
    
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

            t = DateTime.now
            @slot.outtime = t.strftime('%H:%M') 
            @slot.Price = (100 * total_time(@slot))
            params[:slot][:status] = "unbooked"
            params[:slot][:user_id] = ""
            #params[:slot][:slot] = ""
            #params[:slot][:floor_id] = ""
            @slot.update(slot_params)
            UserMailer.with(outtime:@slot.outtime, status:@slot.status, Price:@slot.Price).outtime.deliver_later
            render json:{message: 'Slots updated successfully'}
       else
            render json:{message: 'Slots is not updated successfully'}
       end
    end

    def create
        @slot = Slot.new(slot_params)
        if params[:slot][:slot].to_i <= 5
            if @slot.save
                t=DateTime.now
                @slot.intime = t.strftime('%H:%M')
                in_time_hour = t.strftime('%H').to_i
                in_time_min = t.strftime('%M').to_i
                @slot.user_id = current_user.id
                @slot.save
                UserMailer.with(slot:@slot.slot, car_no:@slot.car_no, intime:@slot.intime, name:@slot.name, status:@slot.status).check.deliver_later
                render json:{message:"Slot is booked"}
            else
                render json:{message:@slot.errors.full_messages}
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
        params.require(:slot).permit(:slot, :car_no, :car_color, :intime, :outtime, :Price, :name, :status, :floor_id, :user_id)

    end

    def total_time(slot_id)
        total_hours = slot_id.outtime.strftime('%H').to_i - slot_id.intime.strftime('%H').to_i
        total_min = slot_id.outtime.strftime('%M').to_i - slot_id.intime.strftime('%M').to_i
        if total_min > 0 
            total_hours = total_hours + 1
        else
            total_hours
        end
    end
 
end