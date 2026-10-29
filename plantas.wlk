import wollok.game.*
import proyectiles.*


class Planta {
    var property position
    var property image 
    var property vida
    var property costoEnSoles
    
    method morir() {
        game.removeVisual(self)
    }


/*    method sacarPlanta() {
        self.morir()
    }

    method recibirDaño(daño){
        vida = vida - daño
        if (vida <= 0) {
            self.morir()
        }
    
*/
}


class LanzaGuisantes inherits Planta {

    method disparar() {
        game.onTick(5000, "dispararLanzaguisantes", {=> self.disparo()})
    }

    method disparo() {
            //managerGuisantes.spawnearGuisante()
            const guisante = new Proyectil(position = game.at(2,2), image = "guisante.png", daño = 10 )
            game.addVisual(guisante)
            guisante.moverse()      
        }

}


class Girasol inherits Planta {
    
    method generacionDeSoles() {
        game.onTick(10000,"produccionDeSol", {
            => self.generarSol()
        })
    }
    //otra generacion que deberia encargarse otro objeto
    method generarSol() {
        self.spawnSol()
    }


}

//Esta clase deberia ir a extras
class Sol{
    game.onTick(5000, "spawnDeSol",{=>self.removeVisual(self)})
}

class Nuez inherits Planta {
    /*
    method recuperarNuez() {
        inserte un mensaje aqui
        self.vida = self.vida + la vida base de la nuez
        no deberia superar la vida base de la nuez
        ejemplo: si la vida base es 100 y la nuez tiene 80 de vida, al recuperar la nuez deberia tener 100 de vida
    }
    */
}


class CerezaBomba inherits Planta {
    /*
    method explotar() {
        Basicamenbte acaba deberia hacer la accion de daño a todo lo que esta al rededor de la cereza bomba
        self.morir()
        
    }
    */
}