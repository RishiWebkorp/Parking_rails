class Floors::FloorsController < ApplicationController
    load_and_authorize_resource except:[:show]

    include Floors::FloorsModule
    before_action :floor_id, only:[:show, :update, :destroy]

    def index
        @floors = Floor.all
        render json: @floors
    end

    def show
       floor_show
    end

    def create
      @floor = Floor.new(floor_params)
      floor_create
    end

    def update
        floor_update
    end

    def destroy
       floor_destroy
    end

    def floor_status
        if @floor.slot.status == "booked"
            render json:{message:"No Slots is available"}
        else
            render json:{message:"Try Again"}
        end
    end

    private

    def floor_id
        @floor = Floor.find_by(floor: params[:id])
    end

    def floor_params
        params.require(:floor).permit(:floor)
    end

    def by_floor
        @floor = Floor.find_by(params[:floor])
    end



end