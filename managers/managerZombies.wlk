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
  override method hacerPorTick(){
    //self.hayEntidades()
    
  }


}