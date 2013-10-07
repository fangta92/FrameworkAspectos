class JoinPoint

  def todas_las_clases
    ObjectSpace.each_object(Class)
  end

  def metodos_de_las_clases
    (todas_las_clases.collect do |clase| metodos_de_una_clase(clase) end).flatten
  end

  def metodos_de_una_clase(clase)
    coleccion = []
    clase.instance_methods(false).each do |metodo| coleccion.push ClaseMetodo.new(clase, metodo) end
    coleccion
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

class ClaseMetodo

  attr_accessor :clase, :metodo

  def initialize(clase, metodo)
    @clase = clase
    @metodo = metodo
  end

  def ==(otraClaseMetodo)
    @clase == otraClaseMetodo.clase && @metodo == otraClaseMetodo.metodo
  end

end