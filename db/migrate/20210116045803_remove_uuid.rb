class RemoveUuid < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.remove :uuid
    end
  end
end
