class Aspecto
  attr_accessor :join_point, :advices, :intercepted_methods

  def initialize(join_point, *advices)
    @join_point = join_point
    @advices = advices
    @intercepted_methods = []
    interceptar
  end

  def interceptar
    @join_point.metodos_que_cumplen.each do |clase_metodo|
      advices_interceptar(clase_metodo)
    end
  end

  def interceptar_metodo(clase_metodo)
    if (@join_point.interesa? clase_metodo)&& !(metodo_interceptado? clase_metodo)
      advices_interceptar(clase_metodo)
    end
  end

  def advices_interceptar(clase_metodo)
    @intercepted_methods << clase_metodo
    @advices.each do |advice|
      advice.interceptar clase_metodo
      print "Interceptando #{clase_metodo.metodo.to_s} en #{clase_metodo.clase.to_s} \n"
    end
  end

  def metodo_interceptado?(clase_metodo)
    @intercepted_methods.include? clase_metodo
  end
end