class Address < ActiveRecord::Base
  belongs_to :adressable, polymorphic: true
  has_one :student
  has_one :school

  validates_presence_of :address

  rails_admin do
    nested do
      configure :student do
        active true
      end

    end

  end
end
