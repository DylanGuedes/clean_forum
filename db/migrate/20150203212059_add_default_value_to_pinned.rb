class AddDefaultValueToPinned < ActiveRecord::Migration
  def change
    change_column :topics, :pinned, :boolean, :default => false
  end

  def down
    change_column :topics, :pinned, :boolean, :default => true
  end
end
