class Photo < ActiveRecord::Base
  attr_accessible :info

  def info= obj
    self[:info] = obj.to_json
  end

  def info
    JSON.parse self[:info]
  end
  
  def last(num)
    Photo.find_by_sql("SELECT * FROM clients ORDER BY clients.id DESC LIMIT #{num}")
  end
end
