class PointCutOr < PointCut
  def interesa? (clase_metodo)
    (@join_point_1.interesa? clase_metodo) || (@join_point_2.interesa? clase_metodo)
  end
end