class Zombie {
  var property position = game.at(8, 0)
  var property image = "zombie.png"
  var property vida = 5
  
  method morir() {
    game.removeVisual(self)
  }
  
  method atacar(planta) {
    
  }

  //Hay que hacer un metodo que haga todo lo que hace un zombie cuando pasa un tick: avanzar, atacar, morir, etc

  
  method avanzar() {
    if (position.x() > 0) {
      position = position.left(1)
      
    } else {
      // zombie llego al final del tablero
      self.morir()
    }}

  method ponerZombie() {
    
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