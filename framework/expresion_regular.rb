class ExpresionRegularMetodos  < JoinPoint

  def initialize(expresiones)
    @expresiones = expresiones
  end

  def metodos_que_cumplen
    metodos_de_las_clases.select do |clase_metodo| @expresiones.all? do
            |expresion| expresion.match clase_metodo.metodo.to_s end  end
  end

  end



class ExpresionRegularClases  < JoinPoint

  def initialize(expresiones)
    @expresiones = expresiones
  end

  def metodos_que_cumplen
    metodos_de_las_clases.select do |clase_metodo| @expresiones.all? do
     |expresion| expresion.match clase_metodo.clase.to_s end  end
  end

end