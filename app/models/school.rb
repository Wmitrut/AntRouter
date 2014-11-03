class School < ActiveRecord::Base
  serialize :arrival, Tod::TimeOfDay
  belongs_to :address

  accepts_nested_attributes_for :address

  validates :name, :address, :arrival, presence: true
end
