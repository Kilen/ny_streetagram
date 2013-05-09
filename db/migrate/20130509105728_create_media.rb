class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :recevies

      t.timestamps
    end
  end
end
