class AddDefaultToExperiencesVote < ActiveRecord::Migration[6.0]
  def change
    change_column :experiences, :vote, :integer, :default => 0
  end
end
