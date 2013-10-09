class PointCut < JoinPoint
  attr_accessor :join_point_1, :join_point_2

  def initialize(join_point_1, join_point_2)
    @join_point_1 = join_point_1
    @join_point_2 = join_point_2
  end
end