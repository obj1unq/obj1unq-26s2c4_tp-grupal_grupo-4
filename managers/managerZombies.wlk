import managers.manager.*
import juego.partida

class ManagerZombies inherits Manager {
  var zombiesMatados = 0

  method zombiesMatados() = zombiesMatados

  // el de plantas y el de zombies se necesitan entre sí: para no tener un ciclo al crearlos,
  // este le pide el de plantas a la partida (igual que el cabezal)
  method managerDePlantas() = partida.managerPlantas()

  // primero se fija si está muerto: así un zombie muerto ya no come ni camina
  override method hacerPorCadaEntidad(zombie) {
    if (zombie.tieneQueMorir()) {
      self.matar(zombie)
    } else if (self.managerDePlantas().hayPlantaEn(zombie.position())) {
      zombie.atacar(self.managerDePlantas().plantaEn(zombie.position()))
    } else {
      zombie.pasarTick()
    }
  }

  // solo cuentan los que mueren: el que llega a la casa termina la partida, no suma puntos
  method matar(zombie) {
    zombiesMatados += 1
    self.sacarDelManager(zombie)
  }

  // consultas sobre la colección: las responde el dueño de la colección
  method algunZombieLlegoALaCasa() = entidades.any({ zombie => zombie.llegoALaCasa() })

  method hayZombiesEnFila(numeroDeFila) = entidades.any({ zombie => zombie.position().y() == numeroDeFila })

  method hayZombieEn(posicion) = entidades.any({ zombie => zombie.position() == posicion })

  method zombieEn(posicion) = entidades.find({ zombie => zombie.position() == posicion })

  method zombiesEn(celdas) = entidades.filter({ zombie => celdas.contains(zombie.position()) })

  // para la planta carnívora y las explosivas
  method dañarZombiesEn(celdas, daño) {
    self.zombiesEn(celdas).forEach({ zombie => zombie.recibirDaño(daño) })
  }
}
