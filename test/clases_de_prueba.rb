# Defino algunas clases para testear
class A
  def aaa

  end
end

class B < A
  def bbb(requerido)

  end
end

class C < A
  def ccc(requerido, opcional=2)

  end
end

class D < C
  def ddd(opcional=2)

  end
end

class E
  def eee(un_nombre)

  end
end

class F
  def fff(un_nombre)

  end
end

class Aridad5
  def metodo_de_aridad_5(a,s,d,f,g)
  end
end

class Persona
  attr_accessor :nombre, :edad

  def initialize(nombre, edad)
    @nombre = nombre
    @edad = edad
  end

  def cualquiera
  end

  def edad_por_dos
    edad*2
  end

end

class Calculadora

  def div(x, y)
    x/y
  end

end

class Guerrero
  attr_accessor :vida

  def transaccion_que_deja_la_vida_en_0_y_lanza_excepcion
    self.vida = 0
    raise 'El guerrero se murio'
  end

  def transaccion_que_baja_50_de_vida
    self.vida = self.vida - 50
  end

  def transaccion_que_anida_transacciones
    self.vida = 100
    self.transaccion_que_deja_la_vida_en_0_y_lanza_excepcion
    self.vida += 50
  end

end
