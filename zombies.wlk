class Zombie {
  var property position 
  var property image = "zombie.png"
  var property vida = 5
  
  method morir() {
    game.removeVisual(self)
  }
  
  method atacar(planta) {
    
  }
  
  method avanzar() {
    
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