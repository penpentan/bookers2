class Book < ApplicationRecord
  belongs_to :user #１つのユーザにN枚の本
  validates :title, presence: true
  validates :body,presence: true,length: { maximum: 200 }
end
