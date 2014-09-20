class AddUrlToPeople < ActiveRecord::Migration
  def change
    add_column :people, :url, :string
  end
end
