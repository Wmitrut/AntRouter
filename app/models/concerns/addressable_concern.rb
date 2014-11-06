module AddressableConcern
    extend ActiveSupport::Concern
    included do
       has_one :address, as: :addressable
       accepts_nested_attributes_for :address
       validates :address, presence: true
    end
end
