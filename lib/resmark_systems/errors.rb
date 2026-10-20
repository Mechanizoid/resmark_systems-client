# frozen_string_literal: true

# Copyright (C) 2026, Christopher Orion Phoenix <hello@chrisphoenix.dev>
# SPDX-License-Identifier: LGPL-3.0-or-later
#
# This file is part of the gem resmark_systems-client.
#
# This gem is free software: you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your option) any
# later version.
#
# resmark_systems-client is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU Lesser General Public License along
# with this program. If not, see <https://www.gnu.org/licenses/>

module ResmarkSystems
  # Base error for the entire gem
  class Error < StandardError; end

  # Specific errors inheriting from my base error
  class ConnectionError < Error; end
  class TimeoutError < Error; end
  class ProtocolError < Error; end

  # Parent class for HTTP status errors
  class ClientError < Error
    attr_reader :response, :status_code

    def initialize(response)
      @response = response
      @status_code = response.code.to_i
      super("HTTP #{@status_code}: #{response.message}")
    end
  end

  # Errors to represent HTTP error status codes
  # 400 Bad Request
  class BadRequestError < ClientError; end
  # 401 Unauthorized
  class UnauthorizedError < ClientError; end
  # 403 Forbidden
  class ForbiddenError < ClientError; end
  # 404 Not Found
  class NotFoundError < ClientError; end
  # 429 Too Many Requests
  class RateLimitError < ClientError; end

  # Class for server errors (status code 5xx)
  class ServerError < Error
    attr_reader :response, :status_code

    def initialize(response)
      @response = response
      @status_code = response.code.to_i
      super("Server error #{@status_code}: #{response.message}")
    end
  end
end
