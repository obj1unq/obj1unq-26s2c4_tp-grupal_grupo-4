import managers.manager.Manager
class ManagerProyectiles inherits Manager{
    override method hacerPorCadaEntidad(proyectil){
        if(proyectil.colsionaConZombie()){
            const zombieColicionado = proyectil.zombieQueColsiono()
            zombieColicionado.colcionConProyectil()
            proyectil.sacarVisual()
            self.sacarEntidad(proyectil)
        }
        else{
            if(proyectil.puedeMover()){
                proyectil.mover()
            }else{
                proyectil.sacarVisual()
                self.sacarEntidad(proyectil)
            }
        }
    }
    override method hacerPorTick(){
      
    }

}
