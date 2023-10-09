class RemoveColumnFromVideos < ActiveRecord::Migration[7.0]
  def change
    remove_column :videos, :video_id, :integer
  end
end
