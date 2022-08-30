# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :image
  enum role: [:voter, :candidate, :admin]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create do
    self.role = :admin
    self.save
  end
end
