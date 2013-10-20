class PointCutOr < PointCut
  def interesa? (clase_metodo)
    @join_points.any? do |join_point|
      join_point.interesa? clase_metodo
    end
  end
end