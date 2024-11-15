class User < ApplicationRecord
    devise :database_authenticatable, :registerable,
           :rememberable, :validatable,
           :trackable

    has_many :posts, dependent: :destroy

    # Constants for roles
    ROLES = %w[admin writer]

    # Role-based methods
    def admin?
        role == "admin"
    end

    def writer?
        role == "writer"
    end

    # Default to user role if no role is assigned
    after_initialize :set_default_role, if: :new_record?

    private

    def set_default_role
        self.role ||= "user"
    end
end
