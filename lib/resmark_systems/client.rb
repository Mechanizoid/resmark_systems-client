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

module ResmarkSystems
  # Client object for interacting with Resmark Systems API
  class Client
    attr_reader :host, :path, :user, :api_key, :token

    def initialize(user:, key:,
                   host: "sandbox.resmarksystems.com",
                   path: "/public/api")
      @host = host
      @user = user
      @api_key = key
      @api_base_uri = URI::HTTPS.build(host: host, path: path)
      @token = ResmarkSystems::Client::Token.new(@api_base_uri, @user,
                                                 @api_key)
    end

    def say_hello
      puts "Hello #{user}, your api key is #{api_key}."
      puts "URL: #{@api_base_uri}"
      puts "Token: #{@token.value}"
    end
  end
end
