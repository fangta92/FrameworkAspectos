class MetodosPorParametro < JoinPoint

  def interesa? (clase_metodo)
    clase_metodo.parametros.any? { |parametro| interesa_parametro? parametro }
  end

end