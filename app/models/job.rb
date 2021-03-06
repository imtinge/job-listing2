class Job < ApplicationRecord
  validates :title, presence: true
  validates :wage_lower_bound, presence: true
  validates :wage_lower_bound, numericality: { greater_than: 0 }
  validates :wage_upper_bound, presence: true
  validates :wage_upper_bound, numericality: { greater_than: :wage_lower_bound }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :contact_email, presence: true, format: { with: VALID_EMAIL_REGEX }

  scope :published, -> { where(is_hidden: false) }
  scope :recent, -> { order('created_at DESC') }
  has_many :resumes

  def hide!
    self.is_hidden = true
    self.save
  end

  def publish!
    self.is_hidden = false
    self.save
  end
end
