import manager.*
import random.*
import entidades.zombies.*

class Oleadas inherits Manager {
  var property managerZombies = null
  var ticksDeEsperaEntreOleadas = 0
  var property numeroDeOleada = 0

  method tiposDisponiblesSegunOleada() { 
    if (numeroDeOleada <= 2) return [{ pos => new Zombie(position = pos) }] 
    if (numeroDeOleada <= 4) return [{ pos => new Zombie(position = pos) }, { pos => new ZombieCono(position = pos) }] 
    return [{ pos => new Zombie(position = pos) }, { pos => new ZombieCono(position = pos) }, { pos => new ZombieCubo(position = pos) }] }


   method crearZombieAleatorio() { 
    const pos = game.at(8, (0 .. 4).anyOne()) 
    return self.tiposDisponiblesSegunOleada().anyOne().apply(pos) 
  }

method generarNuevaOleada() {
  numeroDeOleada += 1 
  if (numeroDeOleada % 5 == 0) { 
    game.say(self, "¡SE ACERCA UNA GRAN HORDA!") 
    }
    const minZombies = numeroDeOleada 
    const maxZombies = numeroDeOleada * 2

    const cantidadBase = (minZombies .. maxZombies).anyOne()
    const cantidadFinal = if (numeroDeOleada % 5 == 0) { cantidadBase * 2 } else { cantidadBase }
     cantidadFinal.times({ i => self.agregarEntidad(self.crearZombieAleatorio()) })
  }


  method desencolarZombie() {
    if(self.hayEntidades()){
     const zombie = Entidades.first() 
     self.sacarEntidad(zombie) managerZombies.agregarEntidad(zombie)
      game.addVisual(zombie)
    }
  }
  /*override method hacerPorTick(){
    self.desencolarZombie()
  }
  override method hacerPorCadaEntidad(entidad){
    if (ticksDeEsperaEntreOleadas == 0) { 
      self.generarNuevaOleada() // Define un tiempo de descanso aleatorio antes de la próxima horda (ej. entre 4 y 8 ticks) 
      ticksDeEsperaEntreOleadas = (4 .. 8).anyOne() 
      } 
      else { 
      ticksDeEsperaEntreOleadas -= 1  
      self.desencolarZombie()
      }
  }
  */

  override method hacerPorTick() { 
    if (not self.hayEntidades()) {
       // Si la cola está vacía, genera una nueva oleada tras un descanso 
       if (ticksDeEsperaEntreOleadas == 0) { 
          self.generarNuevaOleada() 
          ticksDeEsperaEntreOleadas = (50 .. 100).anyOne() // Pausa entre hordas 
          } else { ticksDeEsperaEntreOleadas -= 1 } } 
            else {
               // Mientras haya zombies en cola, libera uno al mapa 
               self.desencolarZombie() } } 
    override method hacerPorCadaEntidad(entidad) { // Queda vacío: la responsabilidad de actualizar zombies es de ManagerZombies } }
}} 