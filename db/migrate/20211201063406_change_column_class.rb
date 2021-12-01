class ChangeColumnClass < ActiveRecord::Migration[6.0]
  def up
    remove_column :users, :line_id, :integer
  end

  def down
    add_column :users, :line_id, :string
  end
end
