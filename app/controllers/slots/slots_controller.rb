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

                if @slot.outtime == nil
                   
                    t = DateTime.now
                    @slot.outtime = t.strftime('%d/%m/%Y %H:%M') 
                    @slot.Price = (100 * total_time(@slot))
                    params[:slot][:status] = "unbooked"
                    params[:slot][:user_id] = ""
                    slot_payment(@slot.Price)
                    @slot.update(slot_params)
                    #UserMailer.with(outtime:@slot.outtime, status:@slot.status, Price:@slot.Price).outtime.deliver_later
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

            if @slot.intime != nil
                if @slot.save
                    t=DateTime.now
                    @slot.intime = t.strftime('%d/%m/%Y %H:%M')
                    in_time_hour = t.strftime('%H').to_i
                    in_time_min = t.strftime('%M').to_i
                    @slot.user_id = current_user.id
                    @slot.save
                    #UserMailer.with(slot:@slot.slot, car_no:@slot.car_no, intime:@slot.intime, name:@slot.name, status:@slot.status).check.deliver_later
                    render json:{message:"Slot is booked on slot number: #{@slot.slot} and car_no: #{@slot.car_no} and Intime is: #{@slot.intime}"}
                else
                    render json:{message:"Slot is not booked.#{@slot.errors.full_messages}" } 
                end
            else
                render json:{message:"Slot is already booked"}
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
    
    #for data time calculation

    def total_time(slot_id)
        check_date = slot_id.outtime.strftime('%d').to_i - slot_id.intime.strftime('%d').to_i

        #if data change so we calculate total hours and minutes
        if check_date > 0
            total_hours = 24 + slot_id.outtime.strftime('%H').to_i - slot_id.intime.strftime('%H').to_i
        else
            total_hours = slot_id.outtime.strftime('%H').to_i - slot_id.intime.strftime('%H').to_i
        end

        if total_hours > 0
            total_min = 60 + slot_id.outtime.strftime('%M').to_i - slot_id.intime.strftime('%M').to_i
        else
            total_min = slot_id.outtime.strftime('%M').to_i - slot_id.intime.strftime('%M').to_i
        end

        if check_date > 0
            if total_min > 0
                total_hours = total_hours + 1
            else
                total_hours
            end
        else
            if total_min > 0
                total_hours = total_hours + 1
            else
                total_hours
            end
        end
    end
 
end 