# frozen_string_literal: true

class User < ApplicationRecord
  include ImageUploader::Attachment(:image)

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :votes, dependent: :destroy
  has_many :polls, dependent: :destroy

  enum role: { voter: 0, admin: 1, candidate: 2 }

  validates :first_name, :last_name, :constituency, presence: true
  validates :cnic, length: { is: 13 }
end
