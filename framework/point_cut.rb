class PointCut < JoinPoint
  attr_accessor :join_points

  def initialize(*join_points)
    @join_points = join_points
  end
end