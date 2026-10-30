import managers.manager.Manager
class ManagerProyectiles inherits Manager{
    override method hacerPorCadaEntidad(proyectil){
        if(self.colicionoConZombie(proyectil)){
            const zombieColicionado = self.listaZombiesColisionados(proyectil).first()
            zombieColicionado.colcionConProyectil(proyectil)
            self.sacarDelManager(proyectil)
  
        }
        else{
            if(proyectil.puedeMover()){
                proyectil.mover()
            }else{
                self.sacarDelManager(proyectil)
            }
        }
    }
    
    override method hacerPorTick(){}
    
    method listaZombiesColisionados(proyectil) {
      return self.listaDeColisiones(proyectil).filter({entidades => entidades.tipo()=="Zombie"})
    }
    method colicionoConZombie(proyectil){
        return not self.listaZombiesColisionados(proyectil).isEmpty()
    }

    

    

}
