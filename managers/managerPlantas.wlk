import managers.manager.*

class ManagerPlantas inherits Manager{
    override method hacerPorCadaEntidad(planta){
        if (planta.tieneQueMorir()){
            self.sacarDelManager(planta)
        } else if (planta.debeActuar()){
            planta.accionar()
        }
    }

    override method hacerPorTick() {
        
    }

}