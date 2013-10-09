class ExpresionRegularMetodos < JoinPoint
  def initialize(expresiones)
    @expresiones = expresiones
  end

  def interesa? (clase_metodo)
    @expresiones.all? do |expresion|
      expresion.match clase_metodo.metodo.to_s
    end
  end
end

class ExpresionRegularClases < JoinPoint
  def initialize(expresiones)
    @expresiones = expresiones
  end

  def interesa? (clase_metodo)
    @expresiones.all? do |expresion|
      expresion.match clase_metodo.clase.to_s
    end
  end
end