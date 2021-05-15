require 'rails_helper'

RSpec.describe Message, type: :model do
  context 'validation' do

    after(:each) do
      Message.destroy_all
    end

    after(:all) do
      Chatroom.destroy_all
    end

    let(:chatroom) { Chatroom.new(name: 'chatroom-test') }

    it 'should validate author presence' do
      message = Message.new()
      message.validate
      expect(message.errors.messages).to include(:author)
      expect(message.errors.messages[:author]).to include("can't be blank")
    end

    it 'should validate content presence' do
      message = Message.new()
      message.validate
      expect(message.errors.messages).to include(:content)
      expect(message.errors.messages[:content]).to include("can't be blank")
    end

    it 'should validate chatroom existence' do
      message = Message.new()
      message.validate
      expect(message.errors.messages).to include(:chatroom)
      expect(message.errors.messages[:chatroom]).to include('must exist')
    end

    it 'should persist a message if validation rules are fullfilled' do
      Message.create(content: 'Hi there', author: 'Joe', chatroom: chatroom)
      expect(Message.count).to eq(1)
    end
  end
end
