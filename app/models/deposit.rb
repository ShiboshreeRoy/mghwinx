class Deposit < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :transaction_id, :amount, presence: true

  enum status: { pending: 'pending', approved: 'approved', rejected: 'rejected' }, _default: 'pending'
end
