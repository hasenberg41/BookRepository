class AddPathToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :path, :string
  end
end
