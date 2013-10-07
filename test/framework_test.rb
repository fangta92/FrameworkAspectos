require 'test/unit'
require_relative '../framework/join_point'
require_relative '../framework/metodos_especificos'
require_relative '../framework/point_cut'
require_relative '../framework/point_cut_and'
require_relative '../framework/point_cut_or'
require_relative '../framework/point_cut_not'

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
  def test_and
    point_cut_and = MetodosEspecificos.new([:to_s]).and MetodosEspecificos.new([:clone])
    assert_empty (point_cut_and.metodos_que_cumplen)
    assert (point_cut_and.metodos_que_cumplen.map { |clase_metodo|
      clase_metodo.metodo }).all? { |metodo| metodo == :to_s || metodo == :clone }
  end

  def test_or
    point_cut_or = MetodosEspecificos.new([:clase, :metodo]).or MetodosEspecificos.new([:clase])
    assert_equal point_cut_or.metodos_que_cumplen.length, 2
    assert point_cut_or.metodos_que_cumplen.include? ClaseMetodo.new(ClaseMetodo, :clase)
    assert point_cut_or.metodos_que_cumplen.include? ClaseMetodo.new(ClaseMetodo, :metodo)
  end

  def test_not
    point_cut_not = MetodosEspecificos.new([:clase]).not
    assert !(point_cut_not.metodos_que_cumplen.include? ClaseMetodo.new(ClaseMetodo, :clase))
  end

end
