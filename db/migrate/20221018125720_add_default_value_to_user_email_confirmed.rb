class AddDefaultValueToUserEmailConfirmed < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :email_confirmed, to: false
  end
end
