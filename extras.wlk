import entidades.entidad.*

class Sol inherits Entidad (image = "sol.png", tipo = "Sol"){

    method aparecer() {
        game.addVisual(self)
        game.schedule(8000, { self.desaparecer() })
    }

    method desaparecer() {
        if (game.hasVisual(self)) {
            game.removeVisual(self)
        }
    }
}
