class User < ApplicationRecord
    has_secure_password
    # mount_uploader :avatar, AvatarUploader
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :username, presence: true, uniqueness: true
    validates :password,
              length: { minimum: 6 },
              if: -> { new_record? || !password.nil? }
    has_many :subjects
    has_one :user_progress          
    
    # validate :valid_email
    # private
    # def valid_email
    #   unless ValidateEmail.valid?(email)
    #     errors.add(:email, 'is not a valid email address')
    #   end
    # end
end    
