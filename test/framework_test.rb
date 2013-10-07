require 'test/unit'
require_relative '../join_point'
require_relative '../metodos_especificos'
require_relative '../point_cut'
require_relative '../point_cut_and'
require_relative '../point_cut_or'

class FrameworkTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Fake test
  def test_fail
    point_cut = MetodosEspecificos.new([:to_s]).and MetodosEspecificos.new([:clone])
    assert_empty (point_cut.metodos_que_cumplen)
    assert (point_cut.metodos_que_cumplen.map {|clase_metodo| clase_metodo.metodo }).all? { |metodo| metodo == :to_s || metodo == :clone }
  end
end
