class Entidad{
    var property position 
    var property image 
    var property tipo  
    

    method colicionaConTipo(entidad, _tipo) {
      return (entidad.tipo() == _tipo)
    }

    method sacarVisual() {
      game.removeVisual(self)
    }

}



class Mob inherits Entidad{
    var property vida = 5

    method tieneQueMorir(){
    return (vida <= 0)
  }
    


}