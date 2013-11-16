class Aspecto

  def self.crear(&bloque)
    builder= AspectoBuilder.new
    builder.instance_eval &bloque
    builder.build
  end

end

class AspectoBuilder

  def initialize
    @mapa_jp = {metodos: MetodosEspecificos,
                jerarquia_de: JerarquiaDeClases,
                clases: ClasesEspecificas,
                expresion_regular: ExpresionRegularMetodos,
                clases_expresion_regular: ExpresionRegularClases,
                accesors: MetodosAccessors,
                getters: Getters,
                setters: Setters,
                aridad: MetodosDeAridad,
                con_parametro: MetodosPorNombreDeParametro,
                con_tipo_de_parametro: MetodosPorTipoDeParametro
    }
    @advices = []
  end

  def point(point_cut)
    @point_cut = point_cut
  end

  def cut(pc)
    pc
  end

  def method_missing(name, *args, &block)
    if (@mapa_jp.key? name)
      @mapa_jp[name].new(*args)
    else
      raise "No hay un join point definido para #{name.to_s}"
    end
  end

  def build
    Aspecto.new(@point_cut, *@advices)
  end

  def antes(&bloque)
    @advices << Before.new(&bloque)
  end

  def despues(&bloque)
    @advices << After.new(&bloque)
  end

  def en(algo, &bloque)
    @advices << InsteadOf.new(&bloque)
  end

  def vez(algo)
  end

  def de
  end

  def ante(algo, &bloque)
    @advices << OnError.new(&bloque)
  end

  def error
  end

end

class JoinPoint

  def &(otro_join_point)
    self.and otro_join_point
  end

  def |(otro_join_point)
    self.or otro_join_point
  end

  def !
    self.not
  end

end