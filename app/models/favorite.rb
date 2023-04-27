class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :book
  validates_uniqueness_of :book_id, scope: :user_id
  # https://qiita.com/nojinoji/items/2c66499848d882c31ffa
end
