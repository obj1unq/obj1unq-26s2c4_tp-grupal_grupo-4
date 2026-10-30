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

  /* aca hice el cambio de que var property vida directamente este vacio y cada 
  clase hija haga ponga su propia vida
  */
    var property vida 

    method tieneQueMorir(){
    return (vida <= 0)


  }
    


}