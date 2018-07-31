class Novel < ApplicationRecord
  belongs_to :osusume
  has_many :comments
  scope :order_like_count, -> { order('like COLLATE "C" DESC') }
end
