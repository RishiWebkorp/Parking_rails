# frozen_string_literal: true

module Floors
  # Create a new
  module FloorsModule
    extend ActiveSupport::Concern

    # for floor creating
  def floor_create
    if params[:floor][:floor].to_i <= 6
      if @floor.save
        render json: { message: "Floor created successfully and floor no is #{@floor.floor}" }
      else
        render json: { message: "Floor creation failed. #{@floor.errors.full_messages}",
                       status: :unprocessable_entity }
      end
    else
      render json: { message: "Floor limit exceeded can't create a new Floor", status: :unprocessable_entity }
    end
  end

    # for floor update
    def floor_update
      if @floor.update(floor_params)
        render json: { message: 'Floor updated successfully' }
      else
        render json: { message: 'Floor update failed' }
      end
    end

    # for floor destroy
    def floor_destroy
      if @floor.destroy
        render json: { message: 'Floor destroyed successfully' }
      else
        render json: { message: 'Floor destroy failed' }
      end
    end

    # for floor show
    def floor_show
      if @floor
        if @floor.slots.all.blank?
          render json: { message: 'no vehicle is parked here' }
        else
          render json: @floor.slots.all
        end
      else
        render json: { message: 'No slots are there currently ' }
      end
    end
  end
end
