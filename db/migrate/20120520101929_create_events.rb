# -*- encoding : utf-8 -*-
class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name,:null=>false
      t.datetime :start_at,:null=>false
      t.integer :mode,:null=>false
      t.integer :mask,:null=>false

      t.timestamps
    end
  end
end
