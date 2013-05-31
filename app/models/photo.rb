class Photo < ActiveRecord::Base
  attr_accessible :info
  before_create :ensure_photo_number_within_specific_range

  MAX_PHOTO = 5000

  def info= obj
    self[:info] = obj.to_json
  end

  def info
    JSON.parse self[:info]
  end
  
  def last(num)
    Photo.find_by_sql("SELECT * FROM clients ORDER BY clients.id DESC LIMIT #{num}")
  end

  private

  def ensure_photo_number_within_specific_range
    if Photo.count >= MAX_PHOTO
      remove_earlier_photos(Photo.count - MAX_PHOTO)
    end
  end

  def remove_earlier_photos(num)
    Photo.order("created_at ASC").limit(num).destroy_all
  end
end
