class CreateBotResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :bot_responses do |t|
      t.string :identifier
      t.integer :seq
      t.string :lang
      t.string :condition
      t.text :message

      t.timestamps
    end
  end
end
