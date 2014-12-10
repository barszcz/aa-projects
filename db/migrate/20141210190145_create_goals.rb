class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.text :aim, null: false
      t.integer :user_id, null: false
      t.boolean :public, null: false, default: true
      t.boolean :completed, null: false, default: false

      t.timestamps
    end
    add_index :goals, :user_id
  end
end
