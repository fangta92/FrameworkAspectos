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


class ResultadoConEstado
  attr_accessor :clase_metodo, :parametros, :instancia, :resultado
  def initialize(clase_metodo, parametros, instancia, resultado)
    @clase_metodo = clase_metodo
    @parametros = parametros
    @instancia = instancia
    @resultado = resultado
  end
end

class TestCacheConEstado < Test::Unit::TestCase

  def setup
    @cache = []
  end

  def teardown
    # Do nothing
  end

  def test_cache_con_estado
    pablo = Persona.new("pablo",20)
    jose = Persona.new("Jose",23)

    cache_posta = @cache
    Aspecto.new(MetodosEspecificos.new(:edad_por_dos),InsteadOf.new do |clase_metodo, *args|

      self.class.class_eval { define_method(:ya_fue_ejecutado) { |clase_metodo, args, instancia| cache_posta.select do |resultado|
        resultado.clase_metodo == clase_metodo
        resultado.parametros == args
        resultado.instancia.instance_variables.all? do |atributo|
          resultado.instancia.instance_variable_get(atributo) == instancia.instance_variable_get(atributo)
        end
      end } }

      resultados = ya_fue_ejecutado(clase_metodo, args, self)

      if !(resultados.empty?)
        resultado = resultados.first.resultado
      else
        resultado = send "__#{clase_metodo.metodo}__".to_sym, *args
        el_resultado = ResultadoConEstado.new(clase_metodo, args, self.clone, resultado)
        cache_posta.push(el_resultado)
        resultado
      end
    end)

    pablo.edad_por_dos
    pablo.edad= 13
    pablo.edad_por_dos
    pablo.edad_por_dos
    pablo.edad_por_dos
    pablo.edad = 15
    pablo.edad_por_dos

    jose.edad_por_dos
    jose.edad_por_dos
    jose.edad_por_dos
    jose.edad = 2
    jose.edad_por_dos
    jose.edad_por_dos
    jose.edad_por_dos


    assert_equal(5,cache_posta.size)
    assert_equal(30,pablo.edad_por_dos)
    assert_equal(4,jose.edad_por_dos)
  end



end