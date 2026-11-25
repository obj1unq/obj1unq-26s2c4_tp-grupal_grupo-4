import managers.manager.Manager

class ManagerProyectiles inherits Manager {
    const managerDeZombies

    override method agregarEntidad(proyectil) {
        super(proyectil)
        game.addVisual(proyectil)
    }

    // si hay un zombie en su celda le pega; si no, avanza; y si llegó al borde, desaparece
    override method hacerPorCadaEntidad(proyectil) {
        if (self.hayZombieDondeEsta(proyectil)) {
            self.impactar(proyectil)
        } else if (proyectil.puedeMover()) {
            self.avanzar(proyectil)
        } else {
            self.sacarDelManager(proyectil)
        }
    }

    method hayZombieDondeEsta(proyectil) = managerDeZombies.hayZombieEn(proyectil.position())

    // después de avanzar se vuelve a mirar: si no, el zombie que estaba en esa celda
    // camina hacia atrás del proyectil en el mismo tick y se cruzan sin tocarse
    method avanzar(proyectil) {
        proyectil.mover()
        if (self.hayZombieDondeEsta(proyectil)) {
            self.impactar(proyectil)
        }
    }

    method impactar(proyectil) {
        managerDeZombies.zombieEn(proyectil.position()).recibirProyectil(proyectil)
        self.sacarDelManager(proyectil)
    }
}
