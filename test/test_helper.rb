require "byebug"
require "minitest/autorun"
require "vcr"
require "verbum/api"

VCR.configure do |c|
  c.cassette_library_dir = "test/cassettes"
  c.hook_into :webmock
end
