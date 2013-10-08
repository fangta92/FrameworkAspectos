class ClasesEspecificas < JoinPoint
  def initialize(clases)
    @clases = clases
  end

  def metodos_que_cumplen
    metodos_de_las_clases.select do |clase_metodo|
      @clases.include? clase_metodo.clase
    end
  end
end