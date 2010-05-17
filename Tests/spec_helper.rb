framework 'Cocoa'
Dir.glob(File.expand_path('../../Classes/*.rb', __FILE__)).each { |test| p test; require test }
require "rubygems" rescue LoadError
require "mocha-on-bacon"


def greater_than(other, &blk)
  yield > other
end


