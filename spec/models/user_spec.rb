require 'rails_helper'

RSpec.describe User, type: :model do
  #subject { User.new(email:"jane.doe@example.com", password:"SecretPassword123", name:"john", role:"admin") }
  let(:subject) { create(:user, email: 'jane.doe@example.com') }
  before {subject.save}

  it "email should be present" do
    subject.email = nil
    expect(subject).to_not be_valid
  end
  
  context 'checks email length' do
    it 'is a valid email' do
     expect(subject.email.length).to be_between(5,105).inclusive
    end
    it 'is not a valid email' do
      subject.email = "#{'a'*100}@b.com"
      expect(subject).to_not be_valid
    end
  end

  it "password should be present" do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  describe 'when values are in use' do
    let(:user) { build(:user, email: "jane.doe@example.com") }
    it "when email address is already taken" do
     
    expect(user).to_not be_valid
     expect(user.errors.full_messages).to eq ["Email has already been taken"]
    end
  end



end
