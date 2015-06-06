require 'news_stand'

module NewsStand
  class Memory
    def initialize(options = {})
      @options = options
    end

    def all
      self.class.all
    end

    def get(number)
      self.class.get(number)
    end

    def set(attributes = {})
      self.class.set(attributes)
    end

    class << self
      def issues
        @issues ||= {}
      end

      def all
        issues.values
      end

      def get(key)
        issues[key]
      end

      def set(attributes)
        key = (attributes['number'] ||= next_key)
        issues[key] = attributes
      end

      def next_key
        issues.keys.length + 1
      end

      def reset
        issues.clear
      end
    end
  end
end

NewsStand.register(:memory, NewsStand::Memory)
