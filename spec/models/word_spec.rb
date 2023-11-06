require 'rails_helper'

RSpec.describe Word, type: :model do

  it 'has a valid factory' do
    expect(build(:word)).to be_valid
  end
  
end
