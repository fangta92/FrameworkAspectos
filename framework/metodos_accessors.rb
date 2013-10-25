class MetodosAccessors < JoinPoint

  def interesa?(clase_metodo)
      getter?(clase_metodo) || setter?(clase_metodo)
  end

  def setter?(clase_metodo)
    /[^=]+=$/.match clase_metodo.metodo.to_s
  end

  def getter?(clase_metodo)
    (clase_metodo.clase.instance_methods(false)).include? ((clase_metodo.metodo.to_s + "=")).to_sym
  end

end

class Getters < MetodosAccessors
  def interesa?(clase_metodo)
    getter?(clase_metodo)
  end
end

class Setters < MetodosAccessors
  def interesa?(clase_metodo)
    setter?(clase_metodo)
  end
end