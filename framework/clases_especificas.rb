class ClasesEspecificas < JoinPoint
  def initialize(clases)
    @clases = clases
  end

  def interesa? (clase_metodo)
    @clases.include? clase_metodo.clase
  end
end