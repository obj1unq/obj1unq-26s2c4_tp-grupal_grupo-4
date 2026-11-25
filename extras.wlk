import entidades.entidad.*
import jugador.*

class Sol inherits Entidad (image = "sol.png", tipo = "Sol"){
    const property valor = 25

    method aparecer() {
        game.addVisual(self)
        game.schedule(8000, { self.desaparecer() })
    }

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
