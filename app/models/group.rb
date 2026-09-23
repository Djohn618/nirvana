class Group < ApplicationRecord
  has_paper_trail

  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, source: :user

  validates :name, presence: true, length: { minimum: 3, maximum: 100 }
  validates :description, presence: true
  validates :focus_habit_name, presence: true, length: { minimum: 2, maximum: 100 }
end