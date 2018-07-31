class Novel < ApplicationRecord
  belongs_to :osusume
  has_many :comments
end
