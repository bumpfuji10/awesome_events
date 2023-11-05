class AllowNullOwnerIdInEvents < ActiveRecord::Migration[6.0]
  def change
    change_column_null :events, :owner_id, true
  end
end
