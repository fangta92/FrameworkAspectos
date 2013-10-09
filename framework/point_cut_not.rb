class PointCutNot < JoinPoint
  attr_accessor :join_point

  def initialize(join_point)
    @join_point = join_point
  end

  def interesa? (clase_metodo)
    !(@join_point.interesa? clase_metodo)
  end
end