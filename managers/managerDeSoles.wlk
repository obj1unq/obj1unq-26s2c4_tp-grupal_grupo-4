import extras.Sol
import tablero.*
import random.*

// Tira soles en lugares al azar cada tanto. Cada sol se va solo si nadie lo junta (Sol.aparecer),
// así que no hace falta guardarlos: por eso no hereda de Manager, no tiene ninguna colección.
class ManagerDeSoles {
    const azar = generadorDeNumeros // en los tests se puede reemplazar por un dado cargado
    const ticksMinimosEntreSoles = 10
    const ticksMaximosEntreSoles = 40
    var ticksParaElProximoSol = 2

    method tick() {
        if (ticksParaElProximoSol == 0) {
            self.tirarSol()
        } else {
            ticksParaElProximoSol -= 1
        }
    }

    method tirarSol() {
        new Sol(position = self.posicionAleatoria()).aparecer()
        ticksParaElProximoSol = azar.numeroEntre(ticksMinimosEntreSoles, ticksMaximosEntreSoles)
    }

    // cualquier celda de pasto
    method posicionAleatoria() = game.at(azar.numeroEntre(0, game.width() - 1),
                                         azar.numeroEntre(0, tablero.filaDelPanel() - 1))
}
