class MetodosEspecificos < JoinPoint

  def initialize(metodos)
    @metodos = metodos
  end

  def metodos_que_cumplen
    metodos_de_las_clases.select do |clase_metodo| @metodos.include? clase_metodo.metodo end
  end

end