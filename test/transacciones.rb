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
require_relative '../framework/advice'
require_relative '../framework/aspecto'


class Guerrero
  attr_accessor :vida, :energia

  def transaccion_mortal
    self.vida = 25
    self.energia = 100
  end

end


class MyTest < Test::Unit::TestCase


  def setup
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_a_ver_si_anda
    guerrero = Guerrero.new
    guerrero.vida = 100
    guerrero.energia = 750
    clon = 1
    Aspecto.new(ExpresionRegularMetodos.new([/transaccion_/]),
                Before.new do |clase_metodo, *args|
                clon = self.clone()
                end,
                OnError.new do |clase_metodo, *args|
                self.instance_variables.each do |atributo|
                  self.instance_variable_set(atributo, clon.instance_variable_get(atributo))
                end
                end)

    guerrero.transaccion_mortal
    assert_equal 750, clon.energia
    assert_equal 100, guerrero.energia



  end

end