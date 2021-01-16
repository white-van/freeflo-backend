class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.bigint :stars_count, default: 0
      t.text :description

      t.timestamps
    end
  end
end
