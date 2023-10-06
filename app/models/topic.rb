class Topic < ApplicationRecord
  belongs_to :subject
  has_many :quizzes
  has_many :doubts
  has_many :notes 
  has_many :videos
  has_one :user_progress
end
