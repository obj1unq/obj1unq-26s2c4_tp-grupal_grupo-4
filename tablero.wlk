import wollok.game.*

class CeldaPasto {
    var property position
    method image() = "pasto.jpg"
}

object tablero {

    // TAREA GENERAL: Recorre las filas de abajo hacia arriba
    method dibujarTablero() {
        (0 .. game.height() - 1).forEach({ y => 
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
}

