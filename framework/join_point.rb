class JoinPoint

  def todas_las_clases
    ObjectSpace.each_object(Class)
  end

  def metodos_de_las_clases
    (todas_las_clases.collect do |clase|
      metodos_de_una_clase(clase)
    end).flatten
  end

  def metodos_de_una_clase(clase)
    (clase.instance_methods(false) + clase.private_instance_methods(false)).map do |metodo|
      ClaseMetodo.new(clase, metodo)
    end
  end

  def metodos_que_cumplen
    metodos_de_las_clases.select do |clase_metodo|
      interesa? clase_metodo
    end
  end

  def or(otro_join_point)
    PointCutOr.new(self, otro_join_point)
  end

  def and(otro_join_point)
    PointCutAnd.new(self, otro_join_point)
  end

  def not
    PointCutNot.new(self)
  end
end