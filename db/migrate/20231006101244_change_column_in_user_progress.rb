class ChangeColumnInUserProgress < ActiveRecord::Migration[7.0]
  def change
    change_column :user_progresses, :completed, :string
  end
end
