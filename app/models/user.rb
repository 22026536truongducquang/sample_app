class User < ApplicationRecord
  has_secure_password
  # has_secure_password cung cấp: # rubocop:disable Style/AsciiComments
  # - Các thuộc tính ảo: password, password_confirmation # rubocop:disable Style/AsciiComments
  # - Trường password_digest để lưu hash # rubocop:disable Style/AsciiComments
  # - Phương thức authenticate(password) để xác thực # rubocop:disable Style/AsciiComments

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  NAME_MAX_LENGTH = 50
  EMAIL_MAX_LENGTH = 255
  MAX_YEARS_AGO = 100

  before_save :downcase_email

  scope :recent, -> {order(created_at: :desc)}

  validates :name, presence: true, length: {maximum: NAME_MAX_LENGTH}
  validates :email,
            presence: true,
            length: {maximum: EMAIL_MAX_LENGTH},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  validate :date_of_birth_must_be_within_last_100_years

  enum gender: {male: 0, female: 1, other: 2}

  private

  def downcase_email
    email.downcase!
  end

  def date_of_birth_must_be_within_last_100_years
    return if date_of_birth.blank?

    if date_of_birth < MAX_YEARS_AGO.years.ago.to_date
      errors.add(:date_of_birth, :past_max_year)
    elsif date_of_birth > Time.zone.today
      errors.add(:date_of_birth, :in_future)
    end
  end
end
