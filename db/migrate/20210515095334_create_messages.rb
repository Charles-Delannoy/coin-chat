class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.string :author
      t.references :chatroom, null: false, foreign_key: true

      t.timestamps
    end
  end
end
