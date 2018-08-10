class Novel < ApplicationRecord
  belongs_to :osusume
  has_many :comments
  has_many :reviews
end
