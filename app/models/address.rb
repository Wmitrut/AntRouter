class Address < ActiveRecord::Base
  belongs_to :adressable, polymorphic: true
  has_one :student
  has_one :school

#  validates_presence_of :address

end
