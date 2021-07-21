class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :burden
  belongs_to :delivery
  belongs_to :days_delivery

  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :product_name
    validates :description
    validates :price
  end
  with_options numericality: { other_than: 1, message: "can't be blank " } do
    validates :category_id
    validates :status_id
    validates :burden_id
    validates :delivery_id
    validates :days_delivery_id
  end

  validates :price, numericality: { with: /\A[0-9]+\z/, message: 'Half-width number', allow_blank: true }
  validates :price,
            numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 999_999, message: 'Out of setting range',
                            allow_blank: true }
end
