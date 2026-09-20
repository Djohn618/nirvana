class User < ApplicationRecord
  # --- Passwort-Hashing ---
  # has_secure_password macht:
  # 1. Speichert das Passwort NICHT im Klartext, sondern als Hash
  # 2. Gibt dir eine .authenticate Methode zum Login-Prüfen
  # 3. Verlangt ein password und password_confirmation Feld
  has_secure_password

  # --- Beziehungen ---
  # Ein User hat viele Habits (eigene Gewohnheiten)
  has_many :habits, dependent: :destroy

  # Ein User hat viele HabitLogs (tägliche Einträge)
  has_many :habit_logs, dependent: :destroy

  # Ein User hat viele Memberships (und darüber viele Gruppen)
  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships

  # Ein User kann Gruppen erstellt haben
  has_many :created_groups, class_name: "Group", foreign_key: "creator_id", dependent: :destroy

  # --- Rollen ---
  # enum macht aus der Zahl 0 = "member" und 1 = "admin"
  # Du kannst dann schreiben: user.admin? oder user.member?
  enum :role, { member: 0, admin: 1 }, default: :member

  # --- Validierungen ---
  # Diese Regeln werden geprüft BEVOR etwas in die DB gespeichert wird
  validates :username, presence: true
  validates :email, presence: true,
                     uniqueness: { case_sensitive: false },
                     format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 12 }, if: -> { new_record? || password.present? }

  # --- Normalisierung ---
  # E-Mail wird automatisch in Kleinbuchstaben umgewandelt und getrimmt
  normalizes :email, with: -> (email) { email.strip.downcase }
  normalizes :username, with: -> (username) { username.strip }
end