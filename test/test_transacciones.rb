require 'test/unit'
require_relative 'clases_de_prueba'
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
require_relative '../framework/advice'
require_relative '../framework/aspecto'
require_relative '../framework/metodos_dinamicos'

class MyTest < Test::Unit::TestCase


  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_transaccion_commit
    guerrero = Guerrero.new
    guerrero.vida = 750
    clon = guerrero

    Aspecto.new(ExpresionRegularMetodos.new([/^transaccion_/]),
                InsteadOf.new do |clase_metodo, *args|
                  clon = self.clone()
                  clon.send "__#{clase_metodo.metodo}__".to_sym, *args
                end,
                After.new do |clase_metodo, *args|
                  self.instance_variables.each do |atributo|
                  self.instance_variable_set(atributo, clon.instance_variable_get(atributo))
                  end
                end,
                OnError.new do |clase_metodo, *args| end)

    guerrero.transaccion_que_baja_50_de_vida
    assert_equal 700, guerrero.vida

  end

  def test_transaccion_rollback
    guerrero = Guerrero.new
    guerrero.vida = 1000
    clon = guerrero

    Aspecto.new(ExpresionRegularMetodos.new([/^transaccion_/]),
                InsteadOf.new do |clase_metodo, *args|
                  clon = self.clone()
                  clon.send "__#{clase_metodo.metodo}__".to_sym, *args
                end,
                After.new do |clase_metodo, *args|
                  self.instance_variables.each do |atributo|
                    self.instance_variable_set(atributo, clon.instance_variable_get(atributo))
                  end
                end,
                OnError.new do |clase_metodo, *args| end)

    guerrero.transaccion_que_deja_la_vida_en_0_y_lanza_excepcion
    assert_equal 1000, guerrero.vida
  end

end