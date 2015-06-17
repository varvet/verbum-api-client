require "active_support/all"
require "faraday"
require "json"
require "api_cache"
require "verbum/api/concerns/attributes"
require "verbum/api/concerns/querying"
require "verbum/api/base"
require "verbum/api/author"
require "verbum/api/authorship"
require "verbum/api/psalm"
require "verbum/api/tag"
require "verbum/api/theme"
require "verbum/api/verse"
require "verbum/api/version"

module Verbum
  module Api
    mattr_accessor :wrappers
    self.wrappers = {}

    def self.configure
      yield self
    end
  end
end
