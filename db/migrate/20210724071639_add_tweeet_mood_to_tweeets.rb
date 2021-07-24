class AddTweeetMoodToTweeets < ActiveRecord::Migration[5.1]
  def change
    add_column :tweeets, :tweeet_mood, :string
  end
end
