import random.*
import zombies.*
import wollok.game.* 
class Manager {
  var property Entidades = []

  method agregarEntidad(entidad) {
    Entidades.add(entidad)
  }
  //esto funciona pasandole un bloque de codigo new para generar la cantidad de entidades pedida. Ej manager.agregarCantidadEntidad(10, new Zombie(position.., ... ,))
  method agregarCantidadEntidad(cantidad, entidad) {
    cantidad.times({ i => Entidades.add(entidad.apply(i)) })
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



class ManagerZobies inherits Manager {
  
  override method hacerPorCadaEntidad(entidad) {
    //self.checkearColision(entidad)
    if(entidad.debeMover() and entidad.puedeMover()){ 

    self.moverZombie(entidad)
      }
    self.sacarZombie(entidad)

  }
  override method hacerPorTick(){
    //self.hayEntidades()
    
  }


  method moverZombie(entidad) {
   if (entidad.puedeMover()) { 
    entidad.position(entidad.position().left(1)) 
   }
   }

  method sacarZombie(entidad) {
    if(entidad.tieneQueMorir()){ 
      entidad.morir()
      Entidades.remove(entidad)

    }
  }
}