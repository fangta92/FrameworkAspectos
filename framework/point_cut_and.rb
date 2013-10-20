class PointCutAnd < PointCut
  def interesa? (clase_metodo)
    @join_points.all? do |join_point|
      join_point.interesa? clase_metodo
    end
  end
end


