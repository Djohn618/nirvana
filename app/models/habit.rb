class Habit < ApplicationRecord
  # --- Beziehungen ---
  belongs_to :user
  has_many :habit_logs, dependent: :destroy

  # --- Validierungen ---
  validates :name, presence: true

  # Ein User kann nicht zwei Gewohnheiten mit dem gleichen Namen haben
  validates :name, uniqueness: { scope: :user_id, message: "hast du schon erstellt" }

  # --- Aktivitätsprotokoll ---
  has_paper_trail
end