import proyectiles.*
import entidades.entidad.*
import wollok.game.*
import extras.*
import sonidos.*



class Planta inherits Mob{
    var property costoEnSoles
    const property ticksPorAccion = 5 // podria cambiarlo para cada tipo de planta
    var contadorDeTicks = 0




//TODAVIA NO ESTA IMPLEMENTADO EN LOS ZOMBIES QUE HAGAN DAÑO A LAS PLANTAS. DEBERIA FUNCIONAR.

    method debeActuar(){
        contadorDeTicks += 1
        if (contadorDeTicks >= ticksPorAccion){
            contadorDeTicks = 0
            return true  // revisar, esta mezclando orden con consulta
        } else {
            return false
        }
    }

    method accionar(manager){}


}


class LanzaGuisante inherits Planta (image = "lanzaguisantes.png", costoEnSoles = 100, vida = 5, tipo = "Planta"){
     

    override method accionar(manager){
        self.disparar(manager)
    }

    // todas las que disparan (lanzaguisante, hielaguisante, repetidora) pasan por acá, así el sonido está en un solo lugar
    method disparar(manager){
        efectos.reproducir("disparo.mp3")
        manager.debeDisparar(new Proyectil(position = self.position()))
    }

}

class HielaGuisante inherits LanzaGuisante(image = "hieloguisante.png", costoEnSoles = 150, vida = 5, tipo = "Planta"){
    // por ahora dispara igual que el lanzaguisante (hereda accionar)
    //se creara un proyectil de hielo eventualmente
}

class Repetidora inherits LanzaGuisante(image = "repetidora.png", costoEnSoles = 200, vida = 5, tipo = "Planta"){

    override method accionar(manager){
        self.disparar(manager)
        self.disparar(manager)
    }
    //podriamos crear un nuevo  proyectil que haga mas daño en vez de que dispare 2 proyectiles
}

class Girasol inherits Planta(image = "girasol.png", costoEnSoles = 50, vida = 5, tipo = "Planta" ){


    method generarSol() {
        const sol = new Sol(position = self.position())
        sol.aparecer()
        efectos.reproducir("solGenerado.mp3")
    }

    override method accionar(manager){
        self.generarSol()
    }
}

class Nuez inherits Planta (image = "nuez.png", costoEnSoles = 100, vida = 10, tipo = "Planta"){

}

class PlantaCarnivora inherits Planta(image = "plantaCarnivora.png", costoEnSoles = 150, vida = 5, tipo = "Planta", ticksPorAccion = 5){
    const property dañoMortida = 100

    method celdasQueCome() = [
        self.position(),
        self.position().right(1)
    ]

    override method accionar(manager){
            manager.AccionarEn(self.celdasQueCome(), self.dañoMortida())
        }
    }


class PlantaExplosiva inherits Planta{
    const dañoExplosion = 100

    method celdasAlrededor()

    method explotar(manager){
        manager.AccionarEn(self.celdasAlrededor(), dañoExplosion)
        manager.sacarDelManager(self)
    }

    override method accionar(manager){
        self.explotar(manager)
    }
    
}

class Petacereza inherits PlantaExplosiva(image = "petaCereza.png", costoEnSoles = 200, vida = 50, tipo = "Planta", ticksPorAccion = 3){

    override method celdasAlrededor() = [
        self.position(),
        self.position().up(1),
        self.position().down(1),
        self.position().left(1),
        self.position().right(1),
        self.position().up(1).left(1),
        self.position().up(1).right(1),
        self.position().down(1).left(1),
        self.position().down(1).right(1)
    ]
}

class Patapum inherits PlantaExplosiva(image = "patapum.png", costoEnSoles = 50, vida = 50, tipo = "Planta", ticksPorAccion = 3){

    override method accionar(manager){
        if (vida < 50){
            self.explotar(manager)
        }
    }

    override method celdasAlrededor() = [
        self.position(),
        self.position().left(1),
        self.position().right(1)
    ]
}