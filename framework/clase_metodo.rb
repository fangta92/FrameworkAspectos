class ClaseMetodo
  attr_accessor :clase, :metodo

  def initialize(clase, metodo)
    @clase = clase
    @metodo = metodo
  end

  def ==(otraClaseMetodo)
    @clase == otraClaseMetodo.clase && @metodo == otraClaseMetodo.metodo
  end

  def parametros
    @clase.instance_method(@metodo).parameters
  end
end