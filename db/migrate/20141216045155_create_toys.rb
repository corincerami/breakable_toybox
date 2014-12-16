class CreateToys < ActiveRecord::Migration
  def change
    create_table :toys do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.integer :user_id
      t.timestamps
    end
  end
end
