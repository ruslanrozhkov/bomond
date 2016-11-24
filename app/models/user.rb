class User < ActiveRecord::Base
  after_destroy :ensure_an_admin_remains
  validates :name, presence: true, uniqueness: true
  has_secure_password

  private

  def ensure_an_admin_remains
    raise 'Cannot remove last user' if User.count.zero?
  end
end
