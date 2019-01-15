class User < ApplicationRecord
  has_many :weighings
  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
  belongs_to :invitation

  validates_presence_of :email, :hashed_password, :height
  validates_confirmation_of :password
  validate :password_non_blank
  validates_presence_of :invitation_id
  before_create :set_invitation_limit

  attr_accessor :password_confirmation

  def self.authenticate(email, password)
    user = self.find_by_email(email)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    @current_user = user
    user
  end

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end

  def invitation_token
    invitation.token if invitation
  end

  def invitation_token=(token)
    self.invitation = Invitation.find_by_token(token)
  end

  private

  def password_non_blank
    errors.add(:base, "Passwort leer!") if hashed_password.blank?
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def set_invitation_limit
    self.invitation_limit = 100
  end
end