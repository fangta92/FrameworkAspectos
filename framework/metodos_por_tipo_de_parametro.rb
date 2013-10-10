class MetodosPorTipoDeParametro < MetodosPorParametro

  def initialize(tipo)
    @tipo = tipo
  end

  def interesa_parametro? (parametro)
    parametro.first == @tipo
  end

end


