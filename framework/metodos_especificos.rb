class MetodosEspecificos < JoinPoint

  def initialize(*metodos)
    @metodos = metodos
  end

  def interesa? (clase_metodo)
    @metodos.include? clase_metodo.metodo
  end
end