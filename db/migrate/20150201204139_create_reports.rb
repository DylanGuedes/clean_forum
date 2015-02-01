class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.text :description
      t.boolean :pending, :default => true
      t.belongs_to :user
      t.belongs_to :topic
      t.belongs_to :post
      t.string :type
      t.boolean :accepted, :default => nil

      t.timestamps null: false
    end
  end
end
