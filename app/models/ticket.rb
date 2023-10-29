class Ticket < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :event

  validate :comment, length: { maximum: 30 }, allow_blank: true
end
