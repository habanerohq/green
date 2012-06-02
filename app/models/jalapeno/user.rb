module Jalapeno
  class User < ActiveRecord::Base
    include Habanero::Graft
    
    modules = Jalapeno::AuthenticationDeployment.first.active_modules
    devise *modules
=begin
    devise :database_authenticatable, 
      :token_authenticatable, 
      #:confirmable, 
      :recoverable, 
      :registerable, 
      :rememberable, 
      :trackable, 
      :validatable,
      :authentication_keys => [:login]
=end
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

Green.germinate_model('Jalapeno', 'User')
