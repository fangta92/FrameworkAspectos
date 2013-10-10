require 'test/unit'
require_relative '../framework/join_point'
require_relative '../framework/clase_metodo'
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
require_relative '../framework/metodos_accessors'
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
  end

  def test_or
    point_cut_or = MetodosEspecificos.new([:aaa, :bbb]).or MetodosEspecificos.new([:aaa, :ccc])
    assert_equal 3, point_cut_or.metodos_que_cumplen.length
    assert point_cut_or.metodos_que_cumplen.include? ClaseMetodo.new(A, :aaa)
    assert point_cut_or.metodos_que_cumplen.include? ClaseMetodo.new(B, :bbb)
    assert point_cut_or.metodos_que_cumplen.include? ClaseMetodo.new(C, :ccc)
  end

  def test_not
    point_cut_not = MetodosEspecificos.new([:aaa]).not
    assert !(point_cut_not.metodos_que_cumplen.include? ClaseMetodo.new(A, :aaa))
  end

  def test_expresiones_regulares_metodos_failure
    point_cut_expresion = ExpresionRegularMetodos.new([/nohay*/])
    assert (point_cut_expresion.metodos_que_cumplen).empty?
  end

  def test_expresiones_regulares_metodos_ok
    point_cut_expresion = ExpresionRegularMetodos.new([/metodo_de_a*/])
    assert point_cut_expresion.metodos_que_cumplen.include? ClaseMetodo.new(Aridad5, :metodo_de_aridad_5)
  end

  def test_expresiones_regulares_clases_ok
    clases = ExpresionRegularClases.new([/[A-C]/]).metodos_que_cumplen.collect do |clase_metodo|
      clase_metodo.clase
    end
    assert (clases.include? A), "A no está en la jerarquía"
    assert (clases.include? B), "B no está en la jerarquía"
    assert (clases.include? C), "C no está en la jerarquía"
  end

  def test_expresiones_regulares_clases_failure
    #Busca que tendan A,B,C o D y que terminen con 'no'
    point_cut_expresion = ExpresionRegularClases.new([/[A-D]/, /no$/])
    assert (point_cut_expresion.metodos_que_cumplen).empty?
  end

  def test_aridad_5
    aridad_5 = MetodosDeAridad.new(5).and ClasesEspecificas.new([Aridad5])
    assert_equal [ClaseMetodo.new(Aridad5, :metodo_de_aridad_5)], aridad_5.metodos_que_cumplen
  end

  def test_clases_especificas
    clases = ClasesEspecificas.new([B]).metodos_que_cumplen.collect do |clase_metodo|
      clase_metodo.clase
      end
      assert_equal [B], clases
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

  def test_metodos_accessors
    persona = Persona.new
    print Persona.instance_variables
    metodos_accesors = (MetodosAccessors.new.and ClasesEspecificas.new([Persona])).metodos_que_cumplen
    assert_equal [ClaseMetodo.new(Persona, :nombre), ClaseMetodo.new(Persona, :nombre=)], metodos_accesors
  end
end
