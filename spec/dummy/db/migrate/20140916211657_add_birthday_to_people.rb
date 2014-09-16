class AddBirthdayToPeople < ActiveRecord::Migration
  def change
    add_column :people, :birthday, :date
  end
end
