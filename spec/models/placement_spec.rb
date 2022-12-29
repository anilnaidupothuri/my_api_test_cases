# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Placement, type: :model do
  it { should belong_to(:product) }
  it { should belong_to(:order) }
end
