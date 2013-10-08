class JerarquiaDeClases < JoinPoint
  def initialize(clasePadre)
    @clasePadre = clasePadre
  end

  def metodos_que_cumplen
    metodos_de_las_clases.select do |clase_metodo|
      clase_metodo.clase <= @clasePadre
    end
  end
end