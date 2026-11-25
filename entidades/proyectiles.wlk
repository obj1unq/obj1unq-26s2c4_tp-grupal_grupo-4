import entidades.entidad.*

class Proyectil inherits Entidad(image = "proyectil.png") {
    const daño = 10

    method puedeMover() = position.x() < game.width() - 1

    method mover() {
        position = position.right(1)
    }

    // lo que le hace al zombie que toca
    method aplicarEfecto(zombie) {
        zombie.recibirDaño(daño)
    }
}

class ProyectilHelado inherits Proyectil(image = "proyectilHelado.png") {
    // hace el daño normal (super) y además lo frena
    override method aplicarEfecto(zombie) {
        super(zombie)
        zombie.ralentizar()
    }
}
