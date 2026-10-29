class Zombie {
  var property position 
  var property image = "zombie.png"
  var property vida = 20
  
  method morir() {
    if (vida <= 0){
    game.removeVisual(self)
    }   
  }

  method esZombie(){
    return true
  }
  
  method atacar(planta) {
    
  }
  
  method recibirDaño(cantidad){
      vida = vida - cantidad
      self.morir()
  }

  method avanzar() {
    position = position.left(1)
  }

  method moverse() {
    game.onTick(4000, "movimientoZombie", {=> self.avanzar()})
  }
}
/*
class ZombieComun inherits Zombie {
  var image = "zombie.png"
  var vida = 10
}

class ZombieBalde inherits Zombie {
  var image = "zombieBalde.png"
  var vida = 25
}

class ZombieCono inherits Zombie {
  var image = "zombieCono.png"
  var vida = 15
}

*/