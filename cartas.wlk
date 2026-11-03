import wollok.game.*
import entidades.plantas.*
import tablero.*
import juego.*

// Una carta es lo que el jugador elige en el panel: sabe su tecla, cómo se ve y cómo crear su planta.
// Clase abstracta: crearPlantaEn no tiene cuerpo, cada carta concreta lo redefine.
class Carta {
    const property tecla
    const property image

    // cada carta se ubica en la columna de su tecla: la carta 2 en la columna 2
    method position() = game.at(tecla, tablero.filaDelPanel())
    method text() = tecla.toString()
    method textColor() = "FFFFFFFF"

    // el cabezal no pregunta qué carta es: le pide esto a cualquiera (polimorfismo)
    method crearPlantaEn(posicion)
}

object cartaGirasol inherits Carta(tecla = 1, image = "girasol.png") {
    override method crearPlantaEn(posicion) = new Girasol(position = posicion)
}

object cartaLanzaguisante inherits Carta(tecla = 2, image = "cartaLanzaguisante.png") {
    override method crearPlantaEn(posicion) = new LanzaGuisante(position = posicion,
                                                                managerProyectiles = partida.managerProyectiles())
}

object cartaNuez inherits Carta(tecla = 3, image = "nuez.png") {
    override method crearPlantaEn(posicion) = new Nuez(position = posicion)
}

// Más adelante: cartaBomba (tecla 4) y cartaTrampa (tecla 5)

object cartas {
    // para la preentrega solo el lanzaguisante. Para habilitar otra, agregarla a la lista.
    method disponibles() = [cartaLanzaguisante]
}
