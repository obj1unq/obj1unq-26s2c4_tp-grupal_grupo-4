import managers.manager.*


class ManagerZobies inherits Manager {
  
  override method hacerPorCadaEntidad(zombie) {
    //self.checkearColision(entidad)
    if(zombie.puedeMover() and not zombie.tieneQueMorir()){ 
    zombie.moverZombie()
      }else{
        self.sacarDelManager(zombie)
      }
    

  }
  // consulta para la partida: un zombie que ya no puede avanzar llegó a la casa
  method algunZombieLlegoALaCasa() = Entidades.any({ zombie => not zombie.puedeMover() })

  override method hacerPorTick(){
    //self.hayEntidades()
    
  }


}