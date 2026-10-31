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

    // consultas sobre la colección: las responde el dueño de la colección
    method hayPlantaEn(posicion) = Entidades.any({ planta => planta.position() == posicion })

    method plantaEn(posicion) = Entidades.findOrElse({ planta => planta.position() == posicion },
                                                     { self.error("No hay ninguna planta acá") })

    method validarCeldaLibre(posicion) {
        if (self.hayPlantaEn(posicion)) {
            self.error("Ya hay una planta acá")
        }
    }

    method plantar(planta) {
        self.validarCeldaLibre(planta.position())
        self.agregarEntidad(planta)
        game.addVisual(planta)
    }

}
