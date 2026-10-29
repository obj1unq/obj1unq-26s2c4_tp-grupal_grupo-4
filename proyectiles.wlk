

class Proyectil {
    var property position
    var property image = "proyectil.png"
    
    method sacarVisual() {
        game.removeVisual(self)
    }

    method colsionaConZombie() {
        return not game.colliders(self).isEmpty()
    }
    method zombieQueColsiono(){
        return game.colliders(self).first()
    }
    method puedeMover() = position.x() < game.width() - 1

    method mover() {
        position = position.right(1)
        }
    
}