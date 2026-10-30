import entidades.entidad.*
class Zombie inherits Mob(image = "zombie.png", tipo="Zombie", vida = 10){
  var property velocidad = 1
  var property contadorDeTicks = 0
  var property daño 

  
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
      console.println("zombie ataca, vida planta: " + planta.vida())
      planta.recibirDaño(self.daño())
  }

  method colcionConProyectil(proyectil){
    vida -= 10
  }
}