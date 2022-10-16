class AddReferenceToAuthors < ActiveRecord::Migration[7.0]
  def change
    add_belongs_to :authors, :user
  end
end
