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

    // double dispatch con el cabezal: por defecto no pasa nada (pasto, plantas, zombies...)
    method tocadoPorCabezal(cabezal) {}

}



class Mob inherits Entidad{

  /* aca hice el cambio de que var property vida directamente este vacio y cada 
  clase hija haga ponga su propia vida
  */
    var property vida 

    method tieneQueMorir(){
    return (vida <= 0)


  }

      method recibirDaño(cantidad){
        vida -= cantidad
  }
    
//subi recibir daño a la clase mob para hacer polimorfismo con las acciones nuevas de las plantas.

}