require 'rails_helper'
RSpec.describe Slots::SlotsController, type: :controller do
  
  describe "GET slots#index" do
    let(:user){create(:user)}
    
    it "Gives an error if user is not authorized" do
      get :index, format: :json  
      expect(response.body).to eq "{\"message\":\"User is not authorised for this action!\"}"
    end

    it "list of all slots" do
      sign_in(user)
      create(:slot)
      get :index, format: :json  
      slots = JSON.parse(response.body)
      expect(slots.count).to eq 1
    end
  end

  describe "GET slots#show" do
    let(:user){create(:user)}
    
    it "showing particular id of slots" do
      sign_in(user)
      slot = create(:slot)
      slot_id = slot.id
      get :show, params: {id: slot.id}, format: :json
      slot = JSON.parse(response.body)
      expect(slot.dig("id")).to eq slot_id
    end
  end

describe "POST slots#create" do
  let(:user){create(:user)}

  it "Creating the slots" do
    sign_in(user)
    slot_params = { slot: {slot:1, car_no:"mp09fg0000", car_color:"", intime:"" ,outtime:"", Price:"", name:"john", status:"booked", floor_id:1, user_id:"" } }
    slot_count = Slot.all.count
    post :create, params:slot_params ,format: :json
    slot = JSON.parse(response.body)
    expect(slot.count).to eq slot_count + 1  
  end

end

describe "PUT slots#update" do
  let(:user){create(:user)}

  it "Updating a slots" do
    sign_in(user) 
    slot = create(:slot)
    patch_id = slot.id
    update_slot_params = {id: slot.id, slot: {slot:1, car_no:"mp09fg0000", car_color:"" ,outtime:"", name:"john", status:"unbooked",floor_id: slot.floor.id, user_id:"" } }
    patch :update, params:update_slot_params ,format: :json
    slot = JSON.parse(response.body)
    expect(slot.dig("message")).to eq "Slots is unbooked and your Amount is 700 "
  end

end
end