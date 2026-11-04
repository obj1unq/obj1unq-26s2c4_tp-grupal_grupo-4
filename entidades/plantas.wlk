import proyectiles.*
import entidades.entidad.*
import wollok.game.*
import extras.*



class Planta inherits Mob{
    var property costoEnSoles
    const property ticksPorAccion = 5 // podria cambiarlo para cada tipo de planta
    var contadorDeTicks = 0


    method recibirDaño(cantidad){
        vida -= cantidad
    }

//TODAVIA NO ESTA IMPLEMENTADO EN LOS ZOMBIES QUE HAGAN DAÑO A LAS PLANTAS. DEBERIA FUNCIONAR.

    method debeActuar(){
        contadorDeTicks += 1
        if (contadorDeTicks >= ticksPorAccion){
            contadorDeTicks = 0
            return true
        } else {
            return false
        }
    }

    method accionar(manager){}


}


class LanzaGuisante inherits Planta (image = "lanzaguisantes.png", costoEnSoles = 100, vida = 5, tipo = "Planta"){
     

    override method accionar(manager){
        
        manager.debeDisparar(new Proyectil(position = self.position()))
    }

}


class Girasol inherits Planta(image = "girasol.png", costoEnSoles = 50, vida = 5, tipo = "Planta" ){


    method generarSol() {
        const sol = new Sol(position = self.position())
        sol.aparecer()
    }

    override method accionar(manager){
        self.generarSol()
    }
}

class Nuez inherits Planta (image = "nuez.png", costoEnSoles = 100, vida = 10, tipo = "Planta"){

}
