# frozen_string_literal: true

class Vote < ApplicationRecord
  validates :user_id, uniqueness: { scope: :poll_id }
  belongs_to :user
  belongs_to :candidate
  belongs_to :poll
  belongs_to :constituency
end
