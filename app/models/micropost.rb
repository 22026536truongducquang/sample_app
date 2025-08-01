class Micropost < ApplicationRecord
  MICROPOST_PERMITTED = %i(content image).freeze
  MEGABYTE_IN_BYTES = 1.megabyte
  MAX_IMAGE_SIZE = 5 * MEGABYTE_IN_BYTES # 5 MB
  IMAGE_DISPLAY_SIZE = [500, 500].freeze

  belongs_to :user

  scope :newest, -> {order created_at: :desc}
  scope :relate_post, ->(user_ids) {where user_id: user_ids}
  has_one_attached :image

  validates :content, presence: true,
length: {maximum: Settings.digits.digit_140}
  validates :image, content_type: {in: Settings.uploads.image_types,
                                   message: :invalid_image_type},
                    size: {less_than: MAX_IMAGE_SIZE,
                           message: :image_too_large}

  has_one_attached :image do |attachable|
    attachable.variant :display,
                       resize_to_limit: IMAGE_DISPLAY_SIZE
  end
end
