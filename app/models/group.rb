class Group < ApplicationRecord
  # --- Beziehungen ---
  # Eine Gruppe gehört einem Ersteller (= ein User)
  belongs_to :creator, class_name: "User"

  # Eine Gruppe hat viele Mitglieder über die Membership-Tabelle
  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, source: :user

  # --- Validierungen ---
  validates :name, presence: true
  validates :description, presence: true

  # --- Aktivitätsprotokoll ---
  has_paper_trail
end