class HabitLog < ApplicationRecord
  # --- Beziehungen ---
  belongs_to :user
  belongs_to :habit

  # --- Validierungen ---
  validates :date, presence: true

  # Pro User, Habit und Tag nur ein Eintrag
  validates :habit_id, uniqueness: {
    scope: [:user_id, :date],
    message: "wurde heute schon eingetragen"
  }

  # Standardwert: nicht erledigt
  attribute :completed, :boolean, default: false

  # --- Aktivitätsprotokoll ---
  has_paper_trail
end