class CreateJoinTableUsersResorts < ActiveRecord::Migration
  def change
    create_join_table :users, :resorts do |t|
      t.index [:user_id, :resort_id]
      t.index [:resort_id, :user_id]
    end
  end
end
