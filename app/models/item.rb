class Item < ApplicationRecord
  # itemのアソシエーション
  belongs_to :user
  has_one :order
  has_one_attached :image # ActiveStorage用

  # ActiveHash用のアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shippingfee
  belongs_to :shippingorigin
  belongs_to :deliverytime

  # itemのバリデーション
  validates  :image, :itemname, :description, presence: true

  # ActiveHashの選択が「---」の時は保存できないようにする
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :condition_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shippingfee_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shippingorigin_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :deliverytime_id, numericality: { other_than: 1, message: "can't be blank" }

  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
