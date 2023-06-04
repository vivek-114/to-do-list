class User < ApplicationRecord
    has_secure_password

    enum role: {
        default_user: 0,
        super_admin: 10
    }

    validates_presence_of :email
    validates_uniqueness_of :email
    has_many :lists
end
