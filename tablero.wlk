import entidades.entidad.*
import wollok.game.*
import jugador.*
import cartas.*

class CeldaPasto inherits Entidad(image = "pasto.jpg", tipo = "Celda") {


}

class CeldaPanel inherits Entidad(image = "panel.png", tipo = "Panel") {

}

object contadorSoles {
    method position() = game.at(0, tablero.filaDelPanel())
    method image() = "sol.png"
    method text() = jugador.soles().toString()
    method textColor() = "000000FF"
}

object tablero {

    // la fila de arriba de todo es el panel, el resto es pasto
    method filaDelPanel() = game.height() - 1

    method esCeldaDePasto(posicion) =
        posicion.x().between(0, game.width() - 1) and posicion.y().between(0, self.filaDelPanel() - 1)

    // TAREA GENERAL: dibuja el pasto de abajo hacia arriba y después el panel
    method dibujarTablero() {
        self.dibujarPasto(self.filaDelPanel())
        self.dibujarPanel()
    }

    // para las pantallas de nombre y final: todo pasto, sin panel
    method cubrirDePasto() {
        self.dibujarPasto(game.height())
    }

    method dibujarPasto(cantidadDeFilas) {
        (0 .. cantidadDeFilas - 1).forEach({ y =>
            self.crearFilaCompleta(y)
        })
    }

    // SUBTAREA 1: Camina horizontalmente por toda esa fila poniendo los bloques
    method crearFilaCompleta(y) {
        (0 .. game.width() - 1).forEach({ x =>
            self.ponerPastoEn(x, y)
        })
    }

    // SUBTAREA 2: Crea el objeto visual y lo agrega al juego
    method ponerPastoEn(x, y) {
        const pasto = new CeldaPasto(position = game.at(x, y))
        game.addVisual(pasto)
    }

    // PANEL: fondo de madera, contador de soles y las cartas disponibles
    method dibujarPanel() {
        (0 .. game.width() - 1).forEach({ x =>
            game.addVisual(new CeldaPanel(position = game.at(x, self.filaDelPanel())))
        })
        game.addVisual(contadorSoles)
        cartas.disponibles().forEach({ carta => game.addVisual(carta) })
    }
}
