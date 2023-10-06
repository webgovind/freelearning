class Quiz < ApplicationRecord
  belongs_to :topic  
  has_many :quiz_questions
end
