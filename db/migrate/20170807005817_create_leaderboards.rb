class CreateLeaderboards < ActiveRecord::Migration
  def change
    create_table :leaderboards do |t|
      t.integer :user_score
      t.string :user_name
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
