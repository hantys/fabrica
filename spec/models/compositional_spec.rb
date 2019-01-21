require 'rails_helper'

RSpec.describe Compositional, type: :model do
  context 'New Compositional' do
    it 'Create valid new user' do
      compositional = create(:compositional)
      expect(compositional).to be_valid
    end
  end
end