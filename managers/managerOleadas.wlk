import manager.*
import random.*
import entidades.zombies.*

class Oleadas inherits Manager {
  var property managerZombies = null
  var ticksDeEsperaEntreOleadas = 0
 
   method crearZombieAleatorio() { 
    const nuevaFila = (0 .. 4).anyOne() 
    const tipoDeZombie = [new Zombie(), new ZombieCono(), new ZombieCubo()].anyOne() 
    tipoDeZombie.position(game.at(8, nuevaFila)) 
    return tipoDeZombie 
  }
method generarNuevaOleada() {
    const cantidadZombies = (3 .. 6).anyOne() // Genera entre 3 y 6 zombies por tanda 
    cantidadZombies.times({ i => self.agregarEntidad(self.crearZombieAleatorio()) }) 
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