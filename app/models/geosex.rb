class Geosex < ActiveRecord::Base
  belongs_to :user

  reverse_geocoded_by :lat, :lng

  after_validation :reverse_geocode

  VALID_LAT_LNG_REGEX = /\d+\.\d+/

  validates :user_id, presence: true, uniqueness: { case_sensitive: false}
  validates :lat, presence: true, format: { with: VALID_LAT_LNG_REGEX },numericality: { greater_than: -90, less_than: 90 }
  validates :lng, presence: true, format: { with: VALID_LAT_LNG_REGEX },numericality: { greater_than: -180, less_than: 180 }
end
