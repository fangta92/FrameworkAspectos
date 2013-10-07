class PointCutNot < JoinPoint

  attr_accessor :join_point

  def initialize(join_point)
    @join_point = join_point
  end

  def metodos_que_cumplen
    metodos_de_las_clases.select do |metodo|
      !(@join_point.metodos_que_cumplen.include? metodo) end
  end

end