module Jalapeno
  class User < ActiveRecord::Base
    include Habanero::Graft
    
    if connection.table_exists?('jalapeno_authentication_deployments') and (ad = Jalapeno::AuthenticationDeployment.first)
      ams = ad.active_modules
      devise *ams
    end

    attr_accessor :login
    attr_accessible :context_id, 
      :context_type, 
      :login, 
      :username, 
      :email, 
      :password, 
      :password_confirmation, 
      :remember_me
    
    def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
    end
  end
end

Jalapeno::User.class_eval { include Jalapeno::UserGraft }

Green.germinate_model('Jalapeno', 'User')
