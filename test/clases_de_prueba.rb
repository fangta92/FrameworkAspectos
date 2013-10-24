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
  attr_accessor :nombre

  def cualquiera

  end

end


class Calculadora
  def div(x, y)
    x/y
  end
end
