import managers.manager.*

class ManagerPlantas inherits Manager{
    const property managerDeProyectiles 
    const property managerDeZombies // para que funcione PetaCereza, Patapum y PlantaCarnivora

    //const property managerDeSoles 

    override method hacerPorCadaEntidad(planta){
        if (planta.tieneQueMorir()){
            self.sacarDelManager(planta)
        } else {
            planta.ejecutarTick(self)
        }
    }

    override method hacerPorTick() {

    }

    //
    method debeDisparar(proyectil){
        managerDeProyectiles.agregarEntidad(proyectil)
        // Mirar Despues, el manager de plantas pone la visual del proyectil
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


    method AccionarEn(celdas, daño){
        managerDeZombies.zombiesEn(celdas).forEach({ zombie => zombie.recibirDaño(daño) })
    }

}
