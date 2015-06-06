class NoGet ; def set(x) ; true ; end ; def all ; true ; end ; end

class NoSet ; def get(x) ; true ; end ; def all ; true ; end ; end

class NoAll ; def get(x) ; true ; end ; def set(x) ; true ; end ; end

class GoodAdapter
  def get(x) ; true ; end
  def set(x) ; true ; end
  def all ; true ; end
end
