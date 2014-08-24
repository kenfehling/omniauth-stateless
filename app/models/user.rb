class User < ActiveRecord::Base
    has_many :authorizations
    validate :name, :email, :presence => true
end