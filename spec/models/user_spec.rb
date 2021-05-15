require 'rails_helper'

RSpec.describe User, type: :model do
  after(:each) do
    User.destroy_all
  end

  context 'validation' do
    it 'should validate nickname uniqueness' do
      User.create(nickname: 'Joe', status: 'available')
      user = User.new(nickname: 'Joe', status: 'available')
      user.validate
      expect(user.errors.messages).to include(:nickname)
      expect(user.errors.messages[:nickname]).to include('has already been taken')
    end

    it 'should validate status to be Available, Busy or Away' do

    end
  end
end
