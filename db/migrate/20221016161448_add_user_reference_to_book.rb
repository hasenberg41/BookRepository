class AddUserReferenceToBook < ActiveRecord::Migration[7.0]
  def change
    add_belongs_to :books, :user
  end
end
