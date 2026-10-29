import entidades.entidad.*


class Proyectil inherits Entidad(image = "proyectil.png", tipo = "Proyectil") {
       
    
    method colsionaConZombie(entidad) {
        return self.colicionaConTipo(entidad, "Zombie")
    }
    //esto lo hace el manager
    
    method puedeMover() = position.x() < game.width() - 1

    method mover() {
        position = position.right(1)
        }
    
}