import managers.manager.*

class ManagerPlantas inherits Manager {
    const managerDeProyectiles
    const managerDeZombies // para saber si hay zombies a tiro y para la carnívora y las explosivas

    // primero se fija si está muerta; si no, le avisa que pasó un tick y la planta decide si le toca actuar
    override method hacerPorCadaEntidad(planta) {
        if (planta.tieneQueMorir()) {
            self.sacarDelManager(planta)
        } else {
            planta.pasarTick(self)
        }
    }

    method lanzar(proyectil) {
        managerDeProyectiles.agregarEntidad(proyectil)
    }

    // consultas sobre la colección: las responde el dueño de la colección
    method hayPlantaEn(posicion) = entidades.any({ planta => planta.position() == posicion })

    method plantaEn(posicion) = entidades.findOrElse({ planta => planta.position() == posicion },
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

    // lo que las plantas necesitan saber de los zombies se lo piden a su manager, que se lo pregunta al de zombies
    method hayZombiesEnFila(numeroDeFila) = managerDeZombies.hayZombiesEnFila(numeroDeFila)

    method zombiesEn(celdas) = managerDeZombies.zombiesEn(celdas)

    method dañarZombiesEn(celdas, daño) {
        managerDeZombies.dañarZombiesEn(celdas, daño)
    }
}
