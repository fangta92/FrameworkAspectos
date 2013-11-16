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
require_relative '../test/clases_de_prueba'


Aspecto.new(ClasesEspecificas.new(Luchador).and(Setters.new), (InsteadOf.new do |clase_metodo, value|
  instance_variable_set("@__#{clase_metodo.metodo.to_s.chop}".to_sym, value)
end))

Aspecto.new(ClasesEspecificas.new(Luchador).and(Getters.new), (InsteadOf.new do |clase_metodo|
  instance_variable_get "@__#{clase_metodo.metodo.to_s}".to_sym
end))

Aspecto.new(ExpresionRegularMetodos.new([/transaccion_/]),
            (After.new do |clase_metodo, *args|
              #Commit
              (self.instance_variables.select do |variable|
                !(/@__.*/.match variable.to_s)
              end)
              .each do |atributo|
                self.instance_variable_set(atributo, instance_variable_get("@__#{atributo.to_s[1..-1]}"))
              end
            end),
            OnError.new do |clase_metodo, *args|
              #Rollback
              (self.instance_variables.select do |variable|
                !(/@__.*/.match variable.to_s)
              end)
              .each do |atributo|
                self.instance_variable_set("@__#{atributo.to_s[1..-1]}", instance_variable_get(atributo))
              end
            end)


  class TransaccionesTest < Test::Unit::TestCase

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