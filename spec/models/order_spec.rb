# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  # it { should validate_presence_of(:total)}
  # it { should validate_numericality_of(:total) }

  it { should belong_to(:user) }

  it { should have_many(:placements) }
  it { should have_many(:products).through(:placements) }

  # it "before_ validation " do
  #   order = Order.create(user_id:1, total:200)

  #   byebug
  # end
end
