require 'rails_helper'

RSpec.describe Slot, type: :model do

  subject { Slot.new(slot:1, car_no:"MP09fz1221", name: "rishi", floor_id:1) }

  before{ subject.save }

  it 'slot should be present' do
    subject.slot = nil
    expect(subject).to_not be_valid
  end

  it 'car_no should be present' do
    subject.car_no = nil
    expect(subject).to_not be_valid
  end

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'floor_id should be present' do
    subject.floor_id = nil
    expect(subject).to_not be_valid
  end

end