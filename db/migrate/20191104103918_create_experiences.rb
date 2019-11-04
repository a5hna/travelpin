class CreateExperiences < ActiveRecord::Migration[6.0]
  def change
    create_table :experiences do |t|
      t.string :longitude
      t.string :latitude
      t.string :title
      t.string :description
      t.string :photo
      t.references :board, null: false, foreign_key: true
      t.integer :vote
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
