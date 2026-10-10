
/*crear el proyectil se hace cargo la planta, proyectil va a ser una clase padre y proyectil normal clase hija, 
class Proyectil {
    
}*/

class Proyectil {
    var property position
    var property image = "proyectil.png"
    
    method borrar() {
        game.removeVisual(self)
    }

    method colisionaConZombie() {

    }
    method mover() {
        if (position.x() < game.width() - 1 ) {
            position = position.right(1)
        } else {
            // proyectil llego al final del tablero
            self.borrar()
        }
    }
}