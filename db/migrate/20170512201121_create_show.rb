class CreateShow < ActiveRecord::Migration[5.1]
  def change
    create_table :shows do |t|
      t.string :name
      t.string :network
      t.string :airdate
      t.string :link
      t.integer :user_id
    end
  end
end
