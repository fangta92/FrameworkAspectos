class Aspecto
  attr_accessor :join_point, :advices

  def initialize(join_point, *advices)
    @join_point = join_point
    @advices = advices
    interceptar
  end

  def interceptar
    @join_point.metodos_que_cumplen.each do |clase_metodo|
      @advices.each do |advice|
        advice.interceptar clase_metodo
      end
    end
  end
end