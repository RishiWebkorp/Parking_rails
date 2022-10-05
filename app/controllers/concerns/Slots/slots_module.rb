module Slots
    module  SlotsModule
        extend ActiveSupport::Concern



        def cal_intime
            t=DateTime.now
            @slot.intime = t.strftime('%d/%m/%Y %H:%M')
            in_time_hour = t.strftime('%H').to_i
            in_time_min = t.strftime('%M').to_i
        end


        def cal_outtime
            t = DateTime.now
            @slot.outtime = t.strftime('%d/%m/%Y %H:%M') 
            @slot.Price = (100 * total_time(@slot))
            params[:slot][:user_id] = ""
            params[:slot][:status] = "unbooked"
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