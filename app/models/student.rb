class Student < ActiveRecord::Base
  belongs_to :address
  belongs_to :school
  accepts_nested_attributes_for :address, :allow_destroy => true
  validates_presence_of :address

end
