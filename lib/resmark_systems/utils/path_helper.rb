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

require "uri"

module ResmarkSystems # :nodoc:
  # Module containing various utility functions
  module Utils
    # Utility module for building the path for API endpoints
    module PathHelper
      def build_uri(base_url, path)
        uri = URI.parse(base_url)
        uri.path = [uri.path, path].map { |p| p.split("/") }
                                   .flatten
                                   .reject(&:empty?)
                                   .join("/")
                                   .prepend("/")
        uri
      end
    end
  end
end
