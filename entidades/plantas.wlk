import proyectiles.*
import entidades.entidad.*
import extras.*
import wollok.game.*



class Planta inherits Mob{
    var property costoEnSoles


    //lo hace el manager
    method morir() {
        game.removeVisual(self)
    }

    /*method recibirDaño(cantidad){
        vida =+ cantidad
    }*/
}


class LanzaGuisante inherits Planta (image = "lanzaguisantes.png", costoEnSoles = 100, vida = 5, tipo = "planta")
                                    {
    const managerProyectiles

    method disparar() {
        const guisante = new Proyectil (position = self.position().right(1))
        managerProyectiles.agergarEntidad(guisante)
        game.addVisual(guisante)
    }
}


class Girasol inherits Planta(image = "girasol.png", costoEnSoles = 50, vida = 5, tipo = "planta" ){


    method generarSol() {
        const sol = new Sol(position = self.position())
        sol.aparecer()
    }
}

class Nuez inherits Planta (image = "nuez.png", costoEnSoles = 100, vida = 100, tipo = "planta"){

}

/*
class Girasol inherits Planta {

        image = "girasol.png"
        costoEnSoles = 25
        vida = 3
    
    method generarSol() {
        
    }
}

class Nuez inherits Planta {
  
        image = "nuez.png"
        costoEnSoles = 50
        vida = 20

}

*/