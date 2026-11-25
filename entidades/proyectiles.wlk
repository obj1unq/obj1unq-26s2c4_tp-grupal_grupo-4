import entidades.entidad.*


class Proyectil inherits Entidad(image = "proyectil.png", tipo = "Proyectil") {
    var property daño = 10

    
    method colsionaConZombie(entidad) {
        return self.colicionaConTipo(entidad, "Zombie")
    }
    //esto lo hace el manager
    
    method puedeMover() = position.x() < game.width() - 1

    method mover() {
        position = position.right(1)
        }
    method aplicarEfecto(zombie) { 
        zombie.recibirDaño(daño)
    } 
    
}

class ProyectilHelado inherits Proyectil(image = "proyectilhielo.png") { 
    override method aplicarEfecto(zombie) { 
        super(zombie)
        zombie.ralentizar() // Aplica el efecto de hielo 
        } }


class ProyectilRojo inherits Proyectil(image = "proyectilfuego.png", daño = 30) { }
    