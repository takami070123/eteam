class PlayLog < ApplicationRecord
  belongs_to :user

  validates :score, :correct_count, :miss_count, presence: true
end
