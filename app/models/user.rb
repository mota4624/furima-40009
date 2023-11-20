class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :nickname, presence: true
  validates :birthdate, presence: true

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'Input full-width characters'} do
    validates :lastname
    validates :firstname
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: 'Input full-width katakana characters' } do
    validates :firstname_kana
    validates :lastname_kana
  end
  
  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: 'Include both letters and number' }




end
