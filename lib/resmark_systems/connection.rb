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
require "uri"
require "json"

module ResmarkSystems
  # Initiates HTTP connections with Resmark Systems servers
  class Connection
    include ResmarkSystems::Utils::PathHelper
    include ResmarkSystems::Utils::HttpErrors

    def initialize(host:, path:, token:)
      @host = host
      @path = path
      @token = token
      @base_uri = URI::HTTPS.build(host: @host, path: @path)
      @headers = {
        "Authorization" => "Bearer #{@token.value}",
        "Content-Type" => "application/json"
      }
    end

    def get(path, query=nil)
      uri = build_uri(@base_uri, path)
      uri.query = URI.encode_www_form(query) unless query.nil?

      req = Net::HTTP::Get.new(uri, @headers)

      request(req)
    end

    def post(path, body=nil, query=nil)
      uri = build_uri(@base_uri, path)
      uri.query = URI.encode_www_form(query) unless query.nil?

      req = Net::HTTP::Post.new(uri, @headers)
      req.body = body.to_json unless body.nil?

      request(req)
    end

    def delete; end # todo

    def request(req)
      Net::HTTP.start(@host, use_ssl: true) do |http|
        http.request(req)
      end
    end
  end
end
