# frozen_string_literal: true

require 'minitest/autorun'

load File.join(__dir__, '../rubocop-correct-config')

# [documents](https://www.rubydoc.info/gems/minitest)

class TestOption < MiniTest::Test
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

  def test_detect_no_longer_exists
    assert_nil Analyze.detect_no_longer_exists(@opt, '')
    r = Analyze.detect_no_longer_exists(@opt, 'Error: The `Style/TrailingComma` cop no longer exists. Please use `Style/TrailingCommaInArguments`, `Style/TrailingCommaInArrayLiteral`, and/or `Style/TrailingCommaInHashLiteral` instead.')
    assert_equal 'Style/TrailingComma', r[0]
    assert_includes(r[1], 'Style/TrailingCommaInArguments')
    assert_includes(r[1], 'Style/TrailingCommaInArrayLiteral')
    assert_includes(r[1], 'Style/TrailingCommaInHashLiteral')
  end

  def test_detect_renamed_cop
    assert_nil Analyze.detect_renamed_cop(@opt, '')
    r = Analyze.detect_renamed_cop(@opt, 'The `Style/SingleSpaceBeforeFirstArg` cop has been renamed to `Layout/SpaceBeforeFirstArg`.')
    assert_equal(r[0], 'Style/SingleSpaceBeforeFirstArg')
    assert_equal(r[1], 'Layout/SpaceBeforeFirstArg')
  end

  def test_detect_removed_cop
    assert_nil Analyze.detect_removed_cop(@opt, '')
    r = Analyze.detect_removed_cop(@opt, 'The `Style/SpaceBeforeModifierKeyword` cop has been removed. Please use `Layout/SpaceAroundKeyword` instead.')
    assert_equal(r[0], 'Style/SpaceBeforeModifierKeyword')
    assert_equal(r[1], 'Layout/SpaceAroundKeyword')
  end

  def test_renamed_and_moved_cop
    assert_nil Analyze.detect_renamed_and_moved_cop(@opt, '')
    r = Analyze.detect_renamed_and_moved_cop(@opt, 'The `Style/OpMethod` cop has been renamed and moved to `Naming/BinaryOperatorParameterName`.')
    assert_equal r[0], 'Style/OpMethod'
    assert_equal r[1], 'Naming/BinaryOperatorParameterName'
  end
end
