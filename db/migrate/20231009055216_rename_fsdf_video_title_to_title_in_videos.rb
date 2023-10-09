class RenameFsdfVideoTitleToTitleInVideos < ActiveRecord::Migration[7.0]
  def change
    rename_column :videos, :video_title, :title 
    rename_column :videos, :video_url, :url 
  end
end
