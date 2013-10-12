class JerarquiaDeClases < JoinPoint
  def initialize(clase_padre)
    @clase_padre = clase_padre
  end

  def interesa? (clase_metodo)
    clase_metodo.clase <= @clase_padre
  end
end