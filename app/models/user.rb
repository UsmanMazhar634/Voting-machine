# frozen_string_literal: true

class User < ApplicationRecord
  include ImageUploader::Attachment(:image)
  include DeviseInvitable::Inviter

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :votes, dependent: :destroy
  has_many :polls, dependent: :destroy

  enum role: { voter: 0, admin: 1, candidate: 2 }

  validates :first_name, length: { in: 2..15 }
  validates :last_name, length: { in: 2..15 }
  validates :cnic, length: { is: 13 }
  validates :role, presence: true
  validates :constituency, length: { maximum: 4 }
end
