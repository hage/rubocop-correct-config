# frozen_string_literal: true

require 'rubygems'
require 'minitest/autorun'
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

  def test_default_config_file
    opt = Option.new([])
    assert_equal opt.filename, Option::DEFAULT_CONFIG_FILE
  end

  def test_specify_config_file
    opt = Option.new(['config'])
    assert_equal opt.filename, 'config'
  end
end

class TestAnalyze < MiniTest::Test
  def setup
    @opt = Option.new([])
  end

  def teardown
    # nothing to do
  end

  def test_detect_wrong_name_space
    assert_nil Analyze.detect_wrong_name_space(@opt, '')
    r = Analyze.detect_wrong_name_space(@opt, '/Users/tura/Dropbox/project/OfficeGC/mitaka-peace/.rubocop.yml: Style/AccessModifierIndentation has the wrong namespace - should be Layout')
    assert_equal 'Style/AccessModifierIndentation', r[0]
    assert_equal 'Layout/AccessModifierIndentation', r[1]
  end
end
