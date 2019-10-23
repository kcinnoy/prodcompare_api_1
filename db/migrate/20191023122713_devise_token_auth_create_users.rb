class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[6.0]
  def change

    change_table(:users) do |t|
      add_column :users, :jti, :string, null: false, default: ''
      add_index :users, :jti
    end
  end
end