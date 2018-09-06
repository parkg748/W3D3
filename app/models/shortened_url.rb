class ShortenedUrl < ApplicationRecord
  validates :long_url, presence: true, uniqueness: true
  
  def self.random_code
    code = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(short_url: code)
      code = SecureRandom.urlsafe_base64
    end
    code
  end
  
  def self.create_short_url(class_object, string)
    ShortenedUrl.create(
      long_url: string,
      short_url: ShortenedUrl.random_code,
      user_id: class_object.id
    )
  end
  
  def num_clicks
    self.visits.length
  end
  
  def num_uniques
    self.visits.select(:user_id).distinct
  end
  
  def num_recent_uniques
    
  end
  
  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'
    
  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: 'Visit'
    
  has_many :visitors,
    through: :visits,
    source: :user
end