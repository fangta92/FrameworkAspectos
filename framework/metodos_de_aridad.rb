class MetodosDeAridad < JoinPoint
  def initialize(aridad)
    @aridad = aridad
  end

  def interesa? (clase_metodo)
    clase_metodo.parametros.length == @aridad
  end
end
