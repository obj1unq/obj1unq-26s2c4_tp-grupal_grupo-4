import entidades.entidad.*
class Zombie inherits Mob(image = "zombie.png", tipo="Zombie", vida = 10){
  var property velocidad = 1
  var property contadorDeTicks = 0
  var property daño 

//movimiento
  method puedeMover() = position.x() > 0
  
  method debeMover() = contadorDeTicks >= velocidad
  
  method avanzarTick() { 
    contadorDeTicks += 1 
    }

  method reiniciarContador() { 
    contadorDeTicks = 0 
    }

  

  method moverZombie() {
    self.avanzarTick() 
    if (self.debeMover()) {
      self.reiniciarContador() 
        if (self.puedeMover()) { 
          position = position.left(1) 
        } 
    }
  }
   

  method atacar(planta) {
      console.println("zombie ataca, vida planta: " + planta.vida())
      planta.recibirDaño(self.daño())
  }

  method colcionConProyectil(proyectil){
    vida -= 10
  }
}   