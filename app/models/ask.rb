class Ask < ActiveRecord::Base
  has_one :answer
  has_and_belongs_to_many :locations
  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :categories, reject_if:
    proc { |attributes| attributes['name'].blank? }
  has_and_belongs_to_many :meetup_times
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 300 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
    length: { maximum: 256}
  validates :locations, presence: true
  validates :meetup_times, presence: true

  scope :not_answered, -> { where answered: false }
  scope :with_location, ->(location) do
    if location
    joins(:locations).where('locations.id' => location)
    else
      all
    end
  end
 end
