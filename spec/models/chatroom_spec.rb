require 'rails_helper'

RSpec.describe Chatroom, type: :model do
  context 'validation' do
    after(:each) do
      Chatroom.destroy_all
    end

    after(:all) do
      Message.destroy_all
    end

    it 'should validate name presence' do
      chatroom = Chatroom.new()
      chatroom.validate
      expect(chatroom.errors.messages).to include(:name)
      expect(chatroom.errors.messages[:name]).to include("can't be blank")
    end

    it 'should validate name uniqueness' do
      Chatroom.create(name: 'chatroom')
      chatroom = Chatroom.new(name: 'chatroom')
      chatroom.validate
      expect(chatroom.errors.messages).to include(:name)
      expect(chatroom.errors.messages[:name]).to include('has already been taken')
    end

    it 'should persist a chatroom if validation rules are fullfulled' do
      Chatroom.create(name: 'chatroom')
      expect(Chatroom.count).to eq(1)
    end
  end

  context 'messages association' do
    it 'shoul link a chatroom to their messages' do
      chatroom = Chatroom.create(name: 'chatroom')
      Message.create(content: 'Hi there', author: 'Joe', chatroom: chatroom)
      expect(Chatroom.count).to eq(1)
      expect(chatroom.messages.count).to eq(1)
    end
  end
end
