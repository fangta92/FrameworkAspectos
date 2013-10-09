class MetodosPorTipoDeParametro < JoinPoint

  def initialize(tipo)
    @tipo = tipo
  end


  def interesa? (clase_metodo)
    clase_metodo.parametros.any? { |parametro| parametro.first == @tipo }
  end
end


