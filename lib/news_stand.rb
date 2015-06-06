require "news_stand/version"
require "news_stand/validator"

module NewsStand
  def self.register(service, adapter)
    raise InvalidAdapter unless is_valid_adapter?(adapter)
    adapters[service] = adapter
  end

  def self.is_valid_adapter?(adapter)
    Validator.new(adapter).valid?
  end

  def self.adapter_for(service)
    raise UnknownAdapter unless adapters.keys.include?(service)
    adapters[service]
  end

  def self.adapters
    @adapters ||= {}
  end

  def self.reset
    @adapters = {}
  end

  class UnknownAdapter < StandardError ; end
  class InvalidAdapter < StandardError ; end
end
