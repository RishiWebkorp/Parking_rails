module Slots
    module  SlotsModule
        extend ActiveSupport::Concern


        #in_time calculation
        def cal_intime
            t=DateTime.now
            @slot.intime = t.strftime('%d/%m/%Y %H:%M')
            in_time_hour = t.strftime('%H').to_i
            in_time_min = t.strftime('%M').to_i
        end

        #outtime calculation
        def cal_outtime
            t = DateTime.now
            @slot.outtime = t.strftime('%d/%m/%Y %H:%M') 
            @slot.Price = (100 * total_time(@slot))
            params[:slot][:user_id] = ""
            params[:slot][:status] = "unbooked"
        end

        # updating the status of slot
        def update_details
            if @slot.outtime == nil
                cal_outtime
                @slot.update(slot_params)   
                #UserMailer.with(outtime:@slot.outtime, status:@slot.status, Price:@slot.Price).outtime.deliver_later
                # slot_payment(@slot.Price)
                render json:{message: "Slots is unbooked and your Amount is #{@slot.Price} "}
            else
                render json:{message: "Slot already Updated"}
                
            end
        end

        #creating a new slot function
        def check_details
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


end