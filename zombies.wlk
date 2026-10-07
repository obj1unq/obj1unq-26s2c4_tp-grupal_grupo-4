class Zombie {
  var property position = game.at(3, 5)
  var property image = "zomb"
  var property vida
  
  method morir() {
    game.removeVisual(self)
  }
  
  method atacar(planta) {
    
  }
  
  method avanzar() {
    
  }
}

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