require "simplecov"

SimpleCov.start do
  add_filter "test"
  minimum_coverage 80.00
end

require "minitest/autorun"
require "mocha/mini_test"
require "webmock/minitest"
require "verbum/api"
