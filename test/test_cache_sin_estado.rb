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


class Resultado
  attr_accessor :clase_metodo, :parametros, :resultado
  def initialize(clase_metodo, parametros, resultado)
    @clase_metodo = clase_metodo
    @parametros = parametros
    @resultado = resultado
  end
end

class TestCacheSinEstado < Test::Unit::TestCase

  def setup
     @cache = []
  end

  def teardown
    # Do nothing
  end

  def test_cache_sin_estado
    calc = Calculadora.new
    cache = @cache
    Aspecto.new(MetodosEspecificos.new(:div),InsteadOf.new do |clase_metodo, *args|

          self.class.class_eval { define_method(:ya_fue_ejecutado) { |clase_metodo, args| cache.select do |resultado|
        resultado.clase_metodo == clase_metodo && resultado.parametros == args
      end } }

      resultados = ya_fue_ejecutado(clase_metodo, args)
      if !(resultados.empty?)
        resultado = resultados.first.resultado
      else
        resultado = send "__#{clase_metodo.metodo}__".to_sym, *args
        el_resultado = Resultado.new(clase_metodo, args, resultado)
        cache.push(el_resultado)
        resultado
      end
    end)


    calc.div(6,2)
    calc.div(6,2)
    calc.div(6,2)
    calc.div(3,1)
    assert_equal(2,cache.size)
    assert_equal(3,calc.div(6,2))

  end



end