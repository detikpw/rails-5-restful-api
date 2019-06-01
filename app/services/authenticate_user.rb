class AuthenticateUser
    def initialize(email, password)
        @email = email
        @password = password
    end

    def perform
        JsonWebToken.encode(user_id: user.id) if user
    end

    private

    attr_reader :email, :password

    def user
        user = User.find_by(email: email)
        raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials) unless user && user.authenticate(password)
        user
    end
end