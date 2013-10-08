
class MetodosPorTipoDeParametro < JoinPoint

  def initialize(tipo)
    @tipo = tipo
  end


  def metodos_que_cumplen
    metodos_de_las_clases.select do |clase_metodo|
      clase_metodo.parametros.any? {|parametro|
        parametro.first == @tipo}
    end
  end
end


