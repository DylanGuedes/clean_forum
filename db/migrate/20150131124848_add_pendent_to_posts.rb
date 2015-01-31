class AddPendentToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :pending, :boolean, :default => false
    add_column :posts, :visible, :boolean, :default => true
    add_column :users, :warn, :float, :default => 0.0
    add_column :posts, :report_description, :text
  end
end
