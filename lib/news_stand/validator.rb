module NewsStand
  class Validator
    REQUIRED_METHODS = [:all, :get, :set]

    def initialize(adapter)
      @adapter = adapter
    end

    def valid?
      REQUIRED_METHODS.each do |meth|
        return false unless @adapter.instance_methods.include?(meth)
      end
      true
    end
  end
end
