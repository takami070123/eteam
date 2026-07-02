class AddHighScoreDateToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :high_score_date, :datetime
  end
end
