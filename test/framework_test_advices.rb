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
require_relative '../framework/metodos_por_parametro'
require_relative '../framework/metodos_por_tipo_de_parametro'
require_relative '../framework/metodos_por_nombre_de_parametro'
require_relative '../framework/metodos_accessors'
require_relative '../framework/aspecto'
require_relative '../framework/advice'
require_relative 'clases_de_prueba'

class Div0 < RuntimeError
end

class Calculadora
  def div(x, y)
    x/y
  end
end

class FrameworkTestAdvices < Test::Unit::TestCase
  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  def test_before
    calc = Calculadora.new
    Aspecto.new(MetodosEspecificos.new(:div),
                Before.new do |x, y|
                  if y == 0 then
                     raise Div0
                  end
                end)
    assert_raise Div0 do
      calc.div(1007,0)
    end
  end
end