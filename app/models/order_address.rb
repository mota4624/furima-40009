class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postalcode, :prefecture, :city, :housenumber, :building, :phone, :token, :order_id

  # バリデーションの処理
  with_options presence: true do
    validates :postalcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :user_id, :item_id, :city, :housenumber, :token, :phone
  end

  validates :phone, numericality: { only_integer: true, message: 'is invalid. Input only number' }
  validate :check_phone_length
  def check_phone_length
    errors.add(:phone, 'is too short') if phone.present? && phone.length < 10
    errors.add(:phone, 'is too long') if phone.present? && phone.length > 11
  end

  validates :prefecture, numericality: { other_than: 1, message: "can't be blank" }

  # 各テーブルにデータを保存する処理
  def save
    # 購入情報を保存する
    order = Order.create(user_id:, item_id:)
    # 発送先情報を保存する
    Address.create(postalcode:, prefecture:, city:, housenumber:, building:,
                   phone:, order_id: order.id)
  end
end
