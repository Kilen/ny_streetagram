class ChangeColumnInfoStringToTextInPhoto < ActiveRecord::Migration
  def up
    change_column :photos, :info, :text
  end

  def down
    change_column :photos, :info, :string
  end
end
