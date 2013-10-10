class MetodosPorNombreDeParametro < MetodosPorParametro

  def initialize(nombre)
    @nombre = nombre
  end

  def interesa_parametro? (parametro)
    parametro.last == @nombre
  end

end