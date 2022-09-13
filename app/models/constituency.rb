# frozen_string_literal: true

class Constituency < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :name, length: { maximum: 4 }
end
