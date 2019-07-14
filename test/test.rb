# frozen_string_literal: true

require 'rubygems'
require 'minitest/autorun'
puts Dir.pwd
load './../rubocop-correct-config'

# [documents](https://www.rubydoc.info/gems/minitest)

class Test < MiniTest::Test
  def setup
    # nothing to do
  end

  def teardown
    # nothing to do
  end

  def test_default_override_false
    opt = Option.new([])
    assert_equal opt.override, false
  end

  def test_override_true
    opt = Option.new(['-o'])
    assert_equal opt.override, true

    opt = Option.new(['--override'])
    assert_equal opt.override, true
  end
end
