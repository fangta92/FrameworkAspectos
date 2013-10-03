class PointCutOr < PointCut

  def metodos_que_cumplen
    @join_point_1.metodos_que_cumplen | @join_point_2.metodos_que_cumplen
  end

end