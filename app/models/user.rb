class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :paragraphs
  has_many :liked,
            through: :likes
  has_many :disliked,
            through: :dislikes

  validates :password,
            presence: true,
            length: { minimum: 6 },
            confirmation: true,
            if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation,
            presence: true,
            if: -> { new_record? || changes[:crypted_password] }

  validates :username,
            presence: true,
            uniqueness: true,
            length: { maximum: 30 },
            format: { with: /\A[a-z0-9\-\s]+\z/,
              message: "must include only lowercase letters, numbers, and hyphens" }

  validates :email,
            presence: true,
            uniqueness: true,
            length: { maximum: 255 },
            format: { with: /\A[^@\s]+@[^@\s]+\z/,
                      message: "must be a valid email address" }
end
