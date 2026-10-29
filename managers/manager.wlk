import random.*
import zombies.*
class Manager {
  var property Entidades = []
  
  method agregarEntidad(entidad) {
    Entidades.add(entidad)
  }
  //esto funciona pasandole un bloque de codigo new para generar la cantidad de entidades pedida. Ej manager.agregarCantidadEntidad(10, new Zombie(position.., ... ,))
  method agregarCantidadEntidad(cantidad, bloque) {
    cantidad.times({ i => Entidades.add(bloque.apply(i)) }) // .apply ejecuta el bloque de codigo que se le pase a la entidad y .time repite un bloque de código un número determinado de veces
  }
  method sacarEntidad(entidad){
    Entidades.remove(entidad)
  }
  method tick() {
    self.hacerPorTick()
    Entidades.forEach({entidad => self.hacerPorCadaEntidad(entidad)})
  }

  method hayEntidades(){
    return not Entidades.isEmpty()
    }


  method hacerPorTick()
  method hacerPorCadaEntidad(entidad)
}


