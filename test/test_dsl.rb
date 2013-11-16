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
require_relative '../framework/dsl'

Aspecto.crear do

  point cut clases(Luchador) & setters

  en vez de do |clase_metodo, value|
    instance_variable_set("@__#{clase_metodo.metodo.to_s.chop}".to_sym, value)
  end

end

Aspecto.crear do

  point cut clases(Luchador) & getters

  en vez de do |clase_metodo|
    instance_variable_get "@__#{clase_metodo.metodo.to_s}".to_sym
  end

end

Aspecto.crear do

  point cut expresion_regular([/transaccion_/])

  despues do |clase_metodo, *args|
    #Commit
    (self.instance_variables.select do |variable|
      !(/@__.*/.match variable.to_s)
    end)
    .each do |atributo|
      self.instance_variable_set(atributo, instance_variable_get("@__#{atributo.to_s[1..-1]}"))
    end
  end

  ante error do |clase_metodo, *args|
    #Rollback
    (self.instance_variables.select do |variable|
      !(/@__.*/.match variable.to_s)
    end)
    .each do |atributo|
      self.instance_variable_set("@__#{atributo.to_s[1..-1]}", instance_variable_get(atributo))
    end
  end

end

class TestDsl < Test::Unit::TestCase

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


  def test_dsl

     aspecto = Aspecto.crear do
      point cut metodos(:aaa, :bbb) | metodos(:aaa, :ccc)

     # before do algo end
     # after do otroalgo end
     end
     point_cut_or = aspecto.join_point
     assert_equal 3, point_cut_or.metodos_que_cumplen.length
     assert point_cut_or.metodos_que_cumplen.include? ClaseMetodo.new(A, :aaa)
     assert point_cut_or.metodos_que_cumplen.include? ClaseMetodo.new(B, :bbb)
     assert point_cut_or.metodos_que_cumplen.include? ClaseMetodo.new(C, :ccc)
  end

  def test_commit_transaction
    david = Luchador.new(5, 10)
    bob =  Luchador.new(2, 10)
    david.transaccion_atacar bob
    #no ataca por que le falta energía
    assert_equal 5, david.energia
    assert_equal 1, bob.vida
  end

  def test_rollback_transaction
    david = Luchador.new(5, 3)
    bob =  Luchador.new(2, 10)
    david.transaccion_atacar bob
    #no ataca por que le falta energía
    assert_equal 3, david.energia
    assert_equal 2, bob.vida
  end

end