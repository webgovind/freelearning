class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.integer :video_id
      t.string :video_title
      t.string :video_url
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
