require 'rails_helper'

RSpec.describe School, :type => :model do
  let(:school) { FactoryGirl.build(:school) }

  it "is valid" do
    expect(school).to be_valid
  end

  it "isn't valid without a name" do
    school.name = nil
    expect(school).not_to be_valid
  end

  it "isn't valid without address" do
    school.address = nil
    expect(school).not_to be_valid
  end

  it "isn't valid without arrival" do
    school.arrival = nil
    expect(school).not_to be_valid
  end
end
