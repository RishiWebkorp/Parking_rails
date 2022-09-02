class Floors::FloorsController < ApplicationController
    load_and_authorize_resource

    before_action :floor_id, only:[:show, :update, :destroy]

    def index
        @floors = Floor.all
        render json: @floors
    end

    def show
        render json: @floor.slots.all
    end

    def create
        @floor = Floor.new(floor_params)
        if params[:floor][:floor].to_i <= 5
            if @floor.save
                render json:{message:"Floor created successfully"}
            else
                render json:{message:"Floor creation failed"}
            end
        else
            render json:{message:"Floor limit exceeded can't create a new Floor"}
        end
    end

    def update
        if @floor.update(floor_params)
            render json:{message:"Floor updated successfully"}
        else
            render json:{message:"Floor update failed"}
        end
    end

    def destroy
        if @floor.destroy
            render json:{message:"Floor destroyed successfully"}
        else
            render json:{message:"Floor destroy failed"}   
        end
    end

    def floor_status
        if @floor.slot.status == "booked"
            render json:{message:"No Slots is available"}
        else
            render json:{message:"Try Again"}
        end
    end

    def floor_slots

    end


    private

    def floor_id
        @floor = Floor.find(params[:id])
    end

    def floor_params
        params.require(:floor).permit(:floor)
    end




end