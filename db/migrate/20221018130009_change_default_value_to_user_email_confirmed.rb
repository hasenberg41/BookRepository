class ChangeDefaultValueToUserEmailConfirmed < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :email_confirmed, from: true, to: false
  end
end
