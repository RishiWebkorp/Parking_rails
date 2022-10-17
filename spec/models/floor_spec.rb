require 'rails_helper'

RSpec.describe Floor, type: :model do
  
  subject { Floor.new(floor: 1) }

  before{ subject.save}

  it 'floor should be present' do
    subject.floor = nil
    expect(subject).to_not be_valid
  end
end