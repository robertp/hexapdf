# -*- encoding: utf-8; frozen_string_literal: true -*-
#
#--
# This file is part of HexaPDF.
#
# HexaPDF - A Versatile PDF Creation and Manipulation Library For Ruby
# Copyright (C) 2014-2023 Thomas Leitner
#
# HexaPDF is free software: you can redistribute it and/or modify it
# under the terms of the GNU Affero General Public License version 3 as
# published by the Free Software Foundation with the addition of the
# following permission added to Section 15 as permitted in Section 7(a):
# FOR ANY PART OF THE COVERED WORK IN WHICH THE COPYRIGHT IS OWNED BY
# THOMAS LEITNER, THOMAS LEITNER DISCLAIMS THE WARRANTY OF NON
# INFRINGEMENT OF THIRD PARTY RIGHTS.
#
# HexaPDF is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public
# License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with HexaPDF. If not, see <http://www.gnu.org/licenses/>.
#
# The interactive user interfaces in modified source and object code
# versions of HexaPDF must display Appropriate Legal Notices, as required
# under Section 5 of the GNU Affero General Public License version 3.
#
# In accordance with Section 7(b) of the GNU Affero General Public
# License, a covered work must retain the producer line in every PDF that
# is created or manipulated using HexaPDF.
#
# If the GNU Affero General Public License doesn't fit your need,
# commercial licenses are available at <https://gettalong.at/hexapdf/>.
#++

require 'hexapdf/type/action'

module HexaPDF
  module Type
    module Actions

      # Represents an URI action dictionary, mostly used for opening Internet pages.
      #
      # See: PDF1.7 s12.6.4.7
      class URI < Action

        define_field :S,     type: Symbol, required: true, default: :URI
        define_field :URI,   type: String, required: true
        define_field :IsMap, type: Boolean

        private

        def perform_validation #:nodoc:
          super
          uri = self[:URI]
          if uri && !uri.ascii_only?
            yield("URIs have to contain ASCII characters only", true)
            uri = uri.dup.force_encoding(Encoding::BINARY)
            uri.encode!(Encoding::US_ASCII, fallback: lambda {|c| "%#{c.ord.to_s(16).upcase}" })
            self[:URI] = uri
          end
        end

      end

    end
  end
end
