class Topic < ApplicationRecord
  belongs_to :subject
  has_many :quizzes
  has_many :doubts
  has_one :note 
  has_one :video
  has_one :user_progress
end
