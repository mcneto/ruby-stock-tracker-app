# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, :last_name, presence: true, length: {maximum:25}
  validates_format_of :email,:with => Devise::email_regexp
end
