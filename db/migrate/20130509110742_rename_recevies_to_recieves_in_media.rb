class RenameReceviesToRecievesInMedia < ActiveRecord::Migration
  def up
    rename_column :media, :recevies, :receives
  end

  def down
    rename_column :media, :receives, :recevies
  end
end
