class CreateDoubts < ActiveRecord::Migration[7.0]
  def change
    create_table :doubts do |t|
      t.string :question
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
