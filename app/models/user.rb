# frozen_string_literal: true

class User < ApplicationRecord
  include ImageUploader::Attachment(:image)

  has_many :votes, dependent: :destroy
  has_many :polls, dependent: :destroy
  enum role: { voter: 0, admin: 1, candidate: 2 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # after_create do
  #   self.role = :admin
  #   self.save
  # end
end
