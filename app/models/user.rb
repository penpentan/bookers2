class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image #画像使用
  has_many :books, dependent: :destroy #booksの内容も同時に削除
  has_many :favorites, dependent: :destroy
  has_many :book_comments,dependent: :destroy

  validates :name, uniqueness: true,length: { in: 2..20 }
  validates :introduction, length: { maximum:50 }

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg',content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [100,100]).processed
  end
end
