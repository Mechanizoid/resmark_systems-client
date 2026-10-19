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

require "net/http"
require "json"
require "time"

module ResmarkSystems
  class Client
    # Handles retrieving an API Token
    class Token
      include ResmarkSystems::Utils::PathHelper

      API_TOKEN_TIMEOUT = 85800

      def initialize(base_url, api_user, api_key)
        @uri = build_uri(base_url, "authenticate")
        @request_body = {
          username: api_user,
          apikey: api_key
        }

        fetch
      end

      def value
        fetch if expired?
        @token
      end

      def to_s
        value
      end

      private

      def fetch
        res = Net::HTTP.post(@uri, @request_body.to_json,
                             {"Content-Type": "application/json"})
        @token = res.body
        @timestamp = Time.now
      end

      def expired?
        Time.now - @timestamp > API_TOKEN_TIMEOUT
      end
    end
  end
end
