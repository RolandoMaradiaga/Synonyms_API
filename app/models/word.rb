class Word < ApplicationRecord
  has_many :synonyms, dependent: :destroy
end
