class UsePartialUniqueIndexesForUsers < ActiveRecord::Migration[5.2]
  def up
    remove_index :users, :email
    remove_index :users, :username

    add_index :users, :email, unique: true,
                              where: 'deleted_at IS NULL',
                              name: 'index_active_users_on_email'
    add_index :users, :username, unique: true,
                                 where: 'deleted_at IS NULL',
                                 name: 'index_active_users_on_username'
  end

  def down
    remove_index :users, name: 'index_active_users_on_email'
    remove_index :users, name: 'index_active_users_on_username'

    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
  end
end
