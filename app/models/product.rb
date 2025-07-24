class Product < ApplicationRecord
  scope :newest_first, -> {order(created_at: :desc)}
end
