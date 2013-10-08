require 'test/unit'
require_relative '../framework/join_point'
require_relative '../framework/metodos_especificos'
require_relative '../framework/point_cut'
require_relative '../framework/point_cut_and'
require_relative '../framework/point_cut_or'
require_relative '../framework/point_cut_not'
require_relative '../framework/expresion_regular'
require_relative '../framework/metodos_de_aridad'
require_relative '../framework/clases_especificas'
require_relative '../framework/jerarquia_de_clases'
require_relative '../framework/metodos_por_tipo_de_parametro'
require_relative 'clases_de_prueba'


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
    assert point_cut_expresion.metodos_que_cumplen.include? ClaseMetodo.new(MetodosEspecificos, :metodos_que_cumplen)
  end

  def test_expresiones_regulares_clases_ok
    point_cut_expresion = ExpresionRegular.new([/Join[P]/, /int/])
    assert point_cut_expresion.clases_que_cumplen.include? JoinPoint
  end

  def test_expresiones_regulares_clases_failure
    point_cut_expresion = ExpresionRegular.new([/Join[P]/, /batman{10}/])
    assert (point_cut_expresion.clases_que_cumplen).empty?
  end

  def test_aridad_5
    aridad_5 = MetodosDeAridad.new(5).and ClasesEspecificas.new([Aridad5])
    assert aridad_5.metodos_que_cumplen.include? ClaseMetodo.new(Aridad5, :metodo_de_aridad_5)
    assert_equal aridad_5.metodos_que_cumplen.length, 1
  end

  def test_clases_especificas
    clases = ClasesEspecificas.new([:ClaseMetodo]).metodos_que_cumplen.collect do |clase_metodo|
      clase_metodo.clase
      end
      assert clases.all? do |clase| clase == ClaseMetodo end
  end

  def test_las_clases_de_la_jerarquia_a_son_abcd
    clases = JerarquiaDeClases.new(A).metodos_que_cumplen.collect do |clase_metodo|
      clase_metodo.clase
    end
    assert (clases.include? A), "A no está en la jerarquía"
    assert (clases.include? B), "B no está en la jerarquía"
    assert (clases.include? C), "C no está en la jerarquía"
    assert (clases.include? D), "D no está en la jerarquía"
  end

  def test_metodos_con_parametro_opcional
    metodos_con_parametro_opcional = MetodosEspecificos.new([:aaa, :bbb, :ccc, :ddd]).and MetodosPorTipoDeParametro.new(:opt)
    assert metodos_con_parametro_opcional.metodos_que_cumplen.include? ClaseMetodo.new(C,:ccc)
    assert metodos_con_parametro_opcional.metodos_que_cumplen.include? ClaseMetodo.new(D,:ddd)
    assert_equal metodos_con_parametro_opcional.metodos_que_cumplen.length, 2
  end
end
