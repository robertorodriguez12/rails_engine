class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def destroy_merchant_and_associations
    items.destroy_all
    self.destroy
  end
end
