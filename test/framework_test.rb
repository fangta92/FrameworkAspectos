require 'test/unit'
require_relative '../framework/join_point'
require_relative '../framework/metodos_especificos'
require_relative '../framework/point_cut'
require_relative '../framework/point_cut_and'
require_relative '../framework/point_cut_or'
require_relative '../framework/point_cut_not'
require_relative '../framework/expresion_regular'


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

  def test_expresiones_regulares_metodos_failure
    point_cut_expresion = ExpresionRegular.new([/metodos_que_cumplen34/])
    assert (point_cut_expresion.metodos_que_cumplen).empty?
  end

  def test_expresiones_regulares_metodos_ok
    point_cut_expresion = ExpresionRegular.new([/metodos_que_c*/])
    assert point_cut_expresion.metodos_que_cumplen.include? ClaseMetodo.new(MetodosEspecificos,:metodos_que_cumplen)
  end

  def test_expresiones_regulares_clases_ok
    point_cut_expresion = ExpresionRegular.new([/Join[P]/,/int/])
    assert point_cut_expresion.clases_que_cumplen.include? ClaseMetodo.new(JoinPoint,:todas_las_clases)
  end

  def test_expresiones_regulares_clases_failure
    point_cut_expresion = ExpresionRegular.new([/Join[P]/,/batman{10}/])
    assert (point_cut_expresion.clases_que_cumplen).empty?
  end

end
