class School < ActiveRecord::Base
  belongs_to :address

  accepts_nested_attributes_for :address, :allow_destroy => true

  validates :name, :address, :arrival, presence: true


end
