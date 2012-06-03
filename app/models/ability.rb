class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Jalapeno::User.new # guest user (not logged in)

    user.permissions.each do |p|
      args = (
        [p.action.abbreviation] <<
        (p.variety.present? ? p.variety.klass.name : :all) <<
        p.conditions
      ).compact!
      
      can *args
    end
  end
end
