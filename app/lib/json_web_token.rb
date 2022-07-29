class JsonWebToken
    HMAC_SERCET = Rails.application.secrets.secret_key_base

    def self.encode(payload, exp = 24.hours.from_now)
        payload[:exp] = exp.to_i

        JWT.encode(payload, HMAC_SERCET)
    end

    def self.decode(token)
        body = JWT.decode(token, HMAC_SERCET)[0]
        HashWithIndifferentAccess.new body

    rescue JWT::DecodeError => e
        raise ExceptionHandler::InvalidToken, e.message
    end
end