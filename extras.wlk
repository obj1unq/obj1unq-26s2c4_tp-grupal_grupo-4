import entidades.entidad.*
import jugador.*

class Sol inherits Entidad(image = "sol.png") {
    const property valor = 25

    // aparece en el tablero y, si nadie lo junta, se va solo
    method aparecer() {
        game.addVisual(self)
        game.schedule(8000, { self.desaparecer() })
    }

    // si ya lo juntaron (o la partida terminó) no está más: ahí no hay nada que sacar
    method desaparecer() {
        if (game.hasVisual(self)) {
            game.removeVisual(self)
        }
    }

    // el cabezal pasó por arriba: se junta solo
    override method tocadoPorCabezal(cabezal) {
        jugador.ganarSoles(valor)
        self.desaparecer()
    }
}
