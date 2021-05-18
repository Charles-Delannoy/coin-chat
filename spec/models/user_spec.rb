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

  context 'self#uniq_nickname?' do
    it 'should return true if nickname is unused' do
      expect(User.uniq_nickname?('test')).to eq(true)
    end

    it 'should return false if nickname is used' do
      User.create(nickname: 'Joe', status: 'Available')
      expect(User.uniq_nickname?('Joe')).to eq(false)
    end
  end

  context 'self#generate_nickname' do
    it 'should return a string' do
      expect(User.generate_nickname).to be_a(String)
    end

    it 'should return a nickname that is unused' do
      expect(User.where(nickname: User.generate_nickname).empty?).to eq(true)
    end
  end

  context 'self#generate_user' do
    it 'should generate a user' do
      expect(User.generate_user).to be_a(User)
    end
    it 'should generate a user with the status Available' do
      expect(User.generate_user.status).to eq('Available')
    end
  end
end
