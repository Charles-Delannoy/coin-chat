require 'rails_helper'

RSpec.describe User, type: :model do
  after(:each) do
    User.destroy_all
  end

  context 'validation' do
    it 'should validate nickname presence' do
      user = User.new(status: 'Available')
      user.validate
      expect(user.errors.messages).to include(:nickname)
      expect(user.errors.messages[:nickname]).to include("can't be blank")
    end

    it 'should validate nickname uniqueness' do
      User.create(nickname: 'Joe', status: 'Available')
      user = User.new(nickname: 'Joe', status: 'Available')
      user.validate
      expect(user.errors.messages).to include(:nickname)
      expect(user.errors.messages[:nickname]).to include('has already been taken')
    end

    it 'should validate status presence' do
      user = User.new(nickname: 'Joe')
      user.validate
      expect(user.errors.messages).to include(:status)
      expect(user.errors.messages[:status]).to include("can't be blank")
    end

    it 'should validate status to be Available, Busy or Away' do
      user = User.new(nickname: 'Joe', status: 'Present')
      user.validate
      expect(user.errors.messages).to include(:status)
      expect(user.errors.messages[:status]).to include('Status should be Available, Busy or Away')
    end

    it 'should persist user if validation rules are fullfilled' do
      user = User.create(nickname: 'Joe', status: 'Available')
      expect(User.count).to eq(1)
    end
  end
end
