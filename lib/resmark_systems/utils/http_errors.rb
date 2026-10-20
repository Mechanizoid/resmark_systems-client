# frozen_string_literal: true

require "net/http"
require "socket"

module ResmarkSystems # :nodoc:
  module Utils
    # Contains list of HTTP errors to help with error handling
    module HttpErrors
      NETWORK_ERRORS = [
        Errno::ECONNREFUSED,
        Errno::ECONNRESET,
        Errno::EHOSTUNREACH,
        EOFError,
        SocketError
      ].freeze

      TIMEOUT_ERRORS = [
        Net::OpenTimeout,
        Net::ReadTimeout
      ].freeze

      PROTOCOL_ERRORS = [
        Net::HTTPBadResponse,
        Net::ProtocolError,
        OpenSSL::SSL::SSLError
      ].freeze

      def handle_http_error(response) # rubocop:disable Metrics/MethodLength
        case response.code.to_i
        when 400
          raise ResmarkSystems::BadRequestError, response
        when 401
          raise ResmarkSystems::UnauthorizedError, response
        when 404
          raise ResmarkSystems::NotFoundError, response
        when 429
          raise ResmarkSystems::RateLimitError, response
        when 400..499
          raise ResmarkSystems::ClientError, response
        when 500..599
          raise ResmarkSystems::ServerError, response
        else
          raise ResmarkSystems::Error, "Unexpected response status: #{response.code}"
        end
      end
    end
  end
end
