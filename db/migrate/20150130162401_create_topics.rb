class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.string :subtitle
      t.belongs_to :section
      t.boolean :pinned
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
