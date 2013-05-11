class InMemoryDatabase
  @@memory = []
  
  def self.data
    @@memory
  end

  def self.store(obj)
    @@memory = obj
  end
end
