# frozen_string_literal: true

class User < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_one_attached :image
  has_many :polls, dependent: :destroy
  enum role: %i[voter admin]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # after_create do
  #   self.role = :admin
  #   self.save
  # end
end
