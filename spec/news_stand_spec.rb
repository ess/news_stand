require 'spec_helper'

describe NewsStand do
  it 'has a version number' do
    expect(NewsStand::VERSION).not_to be nil
  end

  describe '.register' do
    before(:each) do
      described_class.reset
    end

    it 'checks the adapter for validity' do
      expect(described_class).
        to receive(:is_valid_adapter?).
        with(GoodAdapter).
        and_call_original

      described_class.register(:good, GoodAdapter)
    end

    it 'raises InvalidAdapter unless the adapter is valid' do
      expect {described_class.register(:noget, NoGet)}.
        to raise_error(NewsStand::InvalidAdapter)

      expect {described_class.register(:good, GoodAdapter)}.
        not_to raise_error
    end

    it 'stores a reference to the adapter' do
      expect(described_class.adapters[:good]).to eql(nil)
      described_class.register(:good, GoodAdapter)
      expect(described_class.adapters[:good]).not_to eql(nil)
    end
  end

  describe '.is_valid_adapter?' do
    it 'is false if the adapter lacks a get instance method' do
      expect(described_class.is_valid_adapter?(NoGet)).to eql(false)
    end

    it 'is false if the adapter lacks a set instance method' do
      expect(described_class.is_valid_adapter?(NoSet)).to eql(false)
    end

    it 'is false if the adapter lacks an all instance method' do
      expect(described_class.is_valid_adapter?(NoAll)).to eql(false)
    end

    it 'is true if the adapter has all necessary instance methods' do
      expect(described_class.is_valid_adapter?(GoodAdapter)).to eql(true)
    end
  end

  describe '.adapter_for' do
    context 'for an unregistered adapter' do
      it 'raises UnknownAdapter' do
        expect {described_class.adapter_for(:something_random)}.
          to raise_error(NewsStand::UnknownAdapter)
      end
    end

    context 'for a registered adapter' do
      it 'returns the requested adapter class' do
        described_class.register(:good, GoodAdapter)
        expect(described_class.adapter_for(:good)).to eql(GoodAdapter)
      end
    end
  end

  describe '.adapters' do
    it 'is a Hash' do
      expect(described_class.adapters).to be_a(Hash)
    end
  end
  
  describe '.reset' do
    it 'clears out the adapters hash' do
      described_class.register(:good, GoodAdapter)
      expect(described_class.adapters).not_to eql({})
      described_class.reset
      expect(described_class.adapters).to eql({})
    end
  end
end
