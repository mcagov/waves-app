class MakeLdapIdOptionalOnUser < ActiveRecord::Migration
  def change
    change_column_null :users, :ldap_id, true
  end
end
