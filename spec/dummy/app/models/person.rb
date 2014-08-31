class Person < ActiveRecord::Base
  def to_s
    [ first_name, last_name ].compact.join " "
  end
end
