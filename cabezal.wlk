import wollok.game.*
import tablero.*
import jugador.*
import cartas.*
import juego.*

object cabezal {
    var property position = game.at(0, 0)

    method image() = "cabezal.png"

    // MOVIMIENTO: solo dentro del pasto, nunca sobre el panel
    method moverA(destino) {
        if (tablero.esCeldaDePasto(destino)) {
            position = destino
        }
    }

    // PLANTAR: el cabezal traduce la tecla en un pedido, las validaciones las hace cada dueño
    method plantar(carta) {
        self.poner(carta.crearPlantaEn(position))
    }

    method poner(planta) {
        self.managerPlantas().validarCeldaLibre(planta.position()) // antes de cobrar
        jugador.gastarSoles(planta.costoEnSoles())
        self.managerPlantas().plantar(planta)
    }

    method sacar(planta) {
        self.managerPlantas().sacarDelManager(planta)
    }

    method sacarPlantaDeAca() {
        self.sacar(self.managerPlantas().plantaEn(position))
    }

    method managerPlantas() = partida.managerPlantas()

    // TECLAS Y COLISIONES
    method configurar() {
        position = game.at(0, 0)
        game.addVisual(self)
        keyboard.up().onPressDo({ self.moverA(position.up(1)) })
        keyboard.down().onPressDo({ self.moverA(position.down(1)) })
        keyboard.left().onPressDo({ self.moverA(position.left(1)) })
        keyboard.right().onPressDo({ self.moverA(position.right(1)) })
        cartas.disponibles().forEach({ carta =>
            keyboard.num(carta.tecla()).onPressDo({ self.plantar(carta) })
        })
        keyboard.x().onPressDo({ self.sacarPlantaDeAca() })
        // double dispatch: el cabezal no pregunta qué tocó, le avisa al otro y cada uno sabe qué hacer
        game.onCollideDo(self, { algo => algo.tocadoPorCabezal(self) })
        // los errores (sin soles, celda ocupada) los "dice" el cabezal
        game.errorReporter(self)
    }
}
