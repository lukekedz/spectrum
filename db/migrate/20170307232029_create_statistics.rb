class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
        t.belongs_to :team, null: false
        t.integer :rk
        t.integer :g
        t.integer :a
        t.integer :pm
        t.integer :pim
        t.integer :ppp
        t.integer :fow
        t.integer :sog
        t.integer :hit
        t.integer :def
        t.integer :w
        t.integer :sv
        t.integer :so
        t.integer :gaa
        t.integer :sv

        t.timestamps null: false
    end
  end
end
