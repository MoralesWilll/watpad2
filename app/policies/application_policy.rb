class ApplicationPolicy
    attr_reader :user, :record

    # Initialize with the user and the record being accessed
    def initialize(user, record)
      @user = user
      @record = record
    end

    # Default to deny access if not overridden
    def index?
      false
    end

    def show?
      false
    end

    def create?
      false
    end

    def update?
      false
    end

    def destroy?
      false
    end

    # Helper method to check if a user is an admin
    def admin?
      user&.admin?
    end

    # Helper method to check if the user is the owner of the record
    def owner?
      record.user == user
    end
end
