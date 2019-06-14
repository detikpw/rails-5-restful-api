class User < ApplicationRecord
    has_secure_password

    validates_presence_of :username, :email, :password_digest
    validates_uniqueness_of :username, :email
    # TODO Add email validation

    def to_json(options={})
        options[:except] ||= [:password_digest]
        super(options)
    end

    def purchase_history
        Purchase.where(user_id: id)
    end
end
