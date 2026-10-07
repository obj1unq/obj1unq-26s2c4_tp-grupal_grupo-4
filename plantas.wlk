import wollok.game.*



class Planta {
    var property position = game.at(1, 5)
    var property image = "lanzaguisante"
    var property vida = 5
    var property costoEnSoles = 100 
    
    method morir() {
        game.removeVisual(self)
    }
}

class LanzaGuisantes inherits Planta {
     var property position = game.at(1, 5)
      const property image = "lanzaguisante.png"
       const  property  costoEnSoles = 50
        const property vida = 5
    
    method disparar() {
        
    }
}

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