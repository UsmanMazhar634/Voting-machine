# frozen_string_literal: true

class Poll < ApplicationRecord
  belongs_to :user
  has_many :votes, dependent: :destroy

  validates :start_date, presence: true
  validates :end_date, presence: true

  validate :end_date_is_after_start_date

  private

  def end_date_is_after_start_date
    return unless end_date.present? && start_date.present?

    errors.add(:end_date, 'cannot be before the start date') if end_date < start_date
  end
end
