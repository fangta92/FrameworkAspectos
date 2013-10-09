class JerarquiaDeClases < JoinPoint
  def initialize(clasePadre)
    @clasePadre = clasePadre
  end

  def interesa? (clase_metodo)
    clase_metodo.clase <= @clasePadre
  end
end