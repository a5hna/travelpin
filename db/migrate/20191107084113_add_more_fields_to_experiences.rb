class AddMoreFieldsToExperiences < ActiveRecord::Migration[6.0]
  def change
    add_column :experiences, :rating, :integer
    add_column :experiences, :opening_hours, :string
    add_column :experiences, :price_level, :string
    add_column :experiences, :phone_number, :string
    add_column :experiences, :website, :string
    add_column :experiences, :google_url, :string
  end
end
