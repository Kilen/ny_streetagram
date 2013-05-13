class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :info

      t.timestamps
    end
  end
end
