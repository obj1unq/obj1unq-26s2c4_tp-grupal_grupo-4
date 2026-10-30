import manager.*
import random.*
import entidades.zombies.Zombie.*


class Oleadas inherits Manager {
  var property managerZombies = null

  method desencolarZombie() {
    if(self.hayEntidades()){
      const zombie = Entidades.first()
      const nuevaFila = generadorDeNumeros.numeroEntre(0, 4)

      zombie.position(game.at(8, nuevaFila))
      self.sacarEntidad(zombie)
      managerZombies.agregarEntidad(zombie)
      game.addVisual(zombie)
    }
  }
  override method hacerPorTick(){
    self.desencolarZombie()
  }
  override method hacerPorCadaEntidad(entidad){
    //self.sacarEntidad(entidad)

  }
}