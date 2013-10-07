class PointCutOr < PointCut

  def metodos_que_cumplen
    metodos = @join_point_1.metodos_que_cumplen
    @join_point_2.metodos_que_cumplen.each do |metodo|
      if !(metodos.include? metodo)
        metodos.push metodo
      end
    end
    metodos
  end

end