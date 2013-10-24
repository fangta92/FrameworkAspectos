class Module
  alias_method :__method_added__, :method_added

  define_method :method_added do |method_name|
    __method_added__ method_name
    if !(/__.*__/.match method_name)
      ObjectSpace.each_object(Aspecto).each do |aspect|
        aspect.interceptar_metodo(ClaseMetodo.new(self, method_name))
      end
    end
  end
end