class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :occurs_at
      t.string :location

      t.timestamps null: false
    end
  end
end
