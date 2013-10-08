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
  def ccc(opcional=2, requerido)

  end
end

class D < C
  def ddd(opcional=2)

  end
end

class Aridad5
  def metodo_de_aridad_5(a,s,d,f,g)
  end
end
