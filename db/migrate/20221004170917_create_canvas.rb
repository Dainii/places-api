# frozen_string_literal: true

class CreateCanvas < ActiveRecord::Migration[7.0]
  def change
    create_table :canvas do |t|
      t.string :name
      t.string :token
      t.integer :length, default: 50
      t.integer :height, default: 50

      t.timestamps
    end
  end
end
