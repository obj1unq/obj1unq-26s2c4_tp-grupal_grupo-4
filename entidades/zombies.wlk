import entidades.entidad.*
import sonidos.*
class Zombie inherits Mob(image = "zombie.png", tipo="Zombie", vida = 10, position = game.at(0,0)){
  var property velocidad = 1
  var property contadorDeTicks = 0
  var property daño = 10
  
  
  method debeMover(){
    contadorDeTicks += 1
    if(contadorDeTicks >=velocidad){ 
      contadorDeTicks = 0
      return true
    }else { 
    return false}
  }

  method puedeMover() {
    return (not (position.x() == 0))
  }
  method moverZombie() {
   if (self.puedeMover() and self.debeMover()) { 
    self.position(self.position().left(1)) 
   }
   }
   
  method atacar(planta) {
      efectos.reproducir("zombiesComiendo.mp3")
      planta.recibirDaño(self.daño())
  }

  method colcionConProyectil(proyectil){
    efectos.reproducir("impacto.mp3")
    vida -= proyectil.daño()
    proyectil.aplicarEfecto(self)
  }
  
  method ralentizar(){
    game.say(self, "Hace Frio")
    self.retroceder()
  }
  method retroceder(){
    if (position.x() > 0) { 
      position = position.right(1) 
      } 
  }
  method llegoALaCasa() = position.x() == 0
}
class ZombieCono inherits Zombie(image = "zombie_cono.png", vida = 20, velocidad = 3) { // Hereda todo el comportamiento de Zombie sin duplicar código 
  //override method image() ="zombie_cono.png"
}

class ZombieCubo inherits Zombie(image = "zombie_cubo.png", vida = 30, velocidad = 3) { // Hereda todo el comportamiento de Zombie sin duplicar código 
  //override method image() ="zombie_cubo.png"
}