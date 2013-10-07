class PointCutAnd < PointCut
  def metodos_que_cumplen
    @join_point_1.metodos_que_cumplen.select do |mc|
      @join_point_2.metodos_que_cumplen.include? mc end
  end
end


