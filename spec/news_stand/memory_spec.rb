require 'spec_helper'
require 'news_stand/validator'
require 'news_stand/memory'

module NewsStand
  describe Memory do
    let(:adapter) {described_class.new({})}
    let(:issue) {{'number' => 1, 'title' => 'Title'}}

    it 'is a valid NewsStand Adapter' do
      expect(NewsStand::Validator.new(described_class).valid?).to eql(true)
    end

    describe '#set' do
      before(:each) do
        described_class.reset
      end

      it 'is a Hash' do
        expect(adapter.set(issue)).to be_a(Hash)
      end

      context 'without an issue number' do
        let(:setted) {adapter.set(issue)}

        before(:each) do
          issue.delete('number')
        end

        it 'has an issue number' do
          expect(setted['number']).not_to eql(nil)
        end

        it 'contains all other information given' do
          setted.delete('number')
          expect(setted).to eql(issue)
        end
      end

      context 'with an issue number'
    end

    describe '#get' do
      context 'given an existing issue' do
        before(:each) do
          described_class.set(issue)
        end

        it 'is a Hash' do
          expect(described_class.get(1)).to be_a(Hash)
        end

        it 'is the requested issue' do
          expect(described_class.get(1)).to eql(issue)
        end
      end

      context 'given an unknown issue' do
        it 'is nil' do
          expect(adapter.get('unknown')).to eql(nil)
        end
      end
    end

    describe '#all' do
      let(:all) {adapter.all}
      before(:each) do
        described_class.reset
      end

      it 'is an Array' do
        expect(all).to be_a(Array)
      end

      it 'contains all issues that have been set' do
        expect(adapter.all).to eql([])

        adapter.set(issue)

        expect(adapter.all).to eql([issue])
      end
    end
  end
end
