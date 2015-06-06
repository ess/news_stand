require 'spec_helper'
require 'news_stand/validator'

module NewsStand
  describe Validator do
    describe '#valid?' do
      it 'is false if the adapter lacks a get instance method' do
        validator = described_class.new(NoGet)
        expect(validator.valid?).to eql(false)
      end

      it 'is false if the adapter lacks a set instance method' do
        validator = described_class.new(NoSet)
        expect(validator.valid?).to eql(false)
      end

      it 'is false if the adapter lacks an all instance method' do
        validator = described_class.new(NoAll)
        expect(validator.valid?).to eql(false)
      end

      it 'is true if the adapter has all necessary instance methods' do
        validator = described_class.new(GoodAdapter)
        expect(validator.valid?).to eql(true)
      end
    end
  end
end
