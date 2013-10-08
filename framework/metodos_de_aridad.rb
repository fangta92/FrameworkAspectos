class MetodosDeAridad < JoinPoint

  def initialize(aridad)
    @aridad = aridad
  end

  def metodos_que_cumplen
    metodos_de_las_clases.select do |clase_metodo| clase_metodo.clase.instance_method(clase_metodo.metodo).arity == @aridad end
  end


#caso de prueba
  def metodo_de_aridad_5(a,s,d,f,g)
  end

end
