class Membership < ApplicationRecord
  # --- Beziehungen ---
  belongs_to :user
  belongs_to :group

  # --- Rollen innerhalb der Gruppe ---
  enum :role, { member: 0, leader: 1 }, default: :member

  # --- Validierungen ---
  # Ein User kann nur einmal pro Gruppe Mitglied sein
  validates :user_id, uniqueness: { scope: :group_id, message: "is already a member of this group" }
end