class AddEmailConfirmColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email_confirmed, :boolean
    add_column :users, :confirm_token, :string
  end
end
