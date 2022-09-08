# frozen_string_literal: true

class Poll < ApplicationRecord
  belongs_to :user
  has_many :votes, dependent: :destroy
end
