class Advice
  attr_accessor :bloque

  def initialize(&bloque)
    @bloque = bloque
  end

  def metodo_original(clase_metodo)
    nombre_metodo = "__#{clase_metodo.metodo}__".to_sym
    while (clase_metodo.clase.method_defined?(nombre_metodo))
      nombre_metodo = "__#{nombre_metodo}__".to_sym
    end
    nombre_metodo
  end

  def interceptar(clase_metodo)
    metodo_original = metodo_original(clase_metodo)
    metodo_interceptado = metodo_interceptado(@bloque, metodo_original, clase_metodo)
    clase_metodo.clase.class_eval do
      alias_method metodo_original, clase_metodo.metodo
      define_method clase_metodo.metodo, metodo_interceptado
    end
  end
end

class Before < Advice
  def metodo_interceptado(bloque, metodo_original, clase_metodo)
    Proc.new do |*args|
      instance_exec clase_metodo, *args, &bloque
      send metodo_original, *args
    end
  end
end

class After < Advice
  def metodo_interceptado(bloque, metodo_original, clase_metodo)
    Proc.new do |*args|
      send metodo_original, *args
      instance_exec clase_metodo, *args, &bloque
    end
  end
end

class InsteadOf < Advice
  def metodo_interceptado(bloque, metodo_original, clase_metodo)
    Proc.new do |*args|
      instance_exec clase_metodo, *args, &bloque
    end
  end
end

class OnError < Advice
  def metodo_interceptado(bloque, metodo_original, clase_metodo)
    Proc.new do |*args|
      begin
        send metodo_original, *args
      rescue
        instance_exec clase_metodo, *args, &bloque
      end
    end
  end
end
