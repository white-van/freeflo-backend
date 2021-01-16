class CreateBranches < ActiveRecord::Migration[6.0]
  def change
    create_table :branches do |t|
      t.string :name, null: false
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
