class Zombie {
  var property position = game.at(8,0)
  var property velocidad = 1
  var property contadorDeTicks = 0
  var property image = "zombie.png"
  var property vida = 5
  
  method morir() {
    game.removeVisual(self)
  }
  
  method atacar(planta) {
    
  }
  method tieneQueMorir(){
    return (vida == 0 or (position.x() <= 0))
  }

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
}
