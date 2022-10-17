# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

    if user.present?

      if user.role == "admin"
        can :manage, :all
      end
      
      if user.role == "user"
        can [:read], Floor
        can %i[read create update], Slot, user_id: user.id
        can %i[read update destroy], User, id: user.id
        
      end

    end
  end
end
