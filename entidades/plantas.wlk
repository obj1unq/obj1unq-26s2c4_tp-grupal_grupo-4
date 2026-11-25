import proyectiles.*
import entidades.entidad.*
import wollok.game.*
import extras.*
import sonidos.*

// Cada planta actúa cada tantos ticks. Qué hace al actuar lo define cada una en accionar (template method).
class Planta inherits Mob {
    const property costoEnSoles
    const ticksPorAccion = 5
    var ticksDesdeLaUltimaAccion = 0

    // orden: pasa un tick y, si ya le toca, actúa
    method pasarTick(manager) {
        ticksDesdeLaUltimaAccion += 1
        if (self.leTocaActuar()) {
            self.actuar(manager)
        }
    }

    // consulta: solo pregunta, no cambia nada
    method leTocaActuar() = ticksDesdeLaUltimaAccion >= ticksPorAccion

    method actuar(manager) {
        ticksDesdeLaUltimaAccion = 0
        self.accionar(manager)
    }

    // por defecto no hace nada (la nuez solo aguanta)
    method accionar(manager) {}
}


class LanzaGuisante inherits Planta(image = "lanzaguisantes.png", costoEnSoles = 100, vida = 5, ticksPorAccion = 10) {

    // hook: cada planta que dispara elige su proyectil
    method proyectilAUsar() = new Proyectil(position = self.position(), daño = 5)

    override method accionar(manager) {
        if (manager.hayZombiesEnFila(position.y())) {
            self.disparar(manager)
        }
    }

    // todas las que disparan (lanzaguisante, hielaguisante, repetidora) pasan por acá, así el sonido está en un solo lugar
    method disparar(manager) {
        efectos.reproducir("disparo.mp3")
        manager.lanzar(self.proyectilAUsar())
    }
}

class HielaGuisante inherits LanzaGuisante(image = "hieloguisante.png", costoEnSoles = 150) {
    // dispara igual que el lanzaguisante: solo cambia qué proyectil usa
    override method proyectilAUsar() = new ProyectilHelado(position = self.position(), daño = 5)
}

class Repetidora inherits LanzaGuisante(image = "repetidora.png", costoEnSoles = 200) {
    // dispara dos guisantes por vez. Como saldrían de la misma celda en el mismo tick se verían como uno solo,
    // así que tira uno que pega por dos (el doble del lanzaguisante)
    override method proyectilAUsar() = new Proyectil(position = self.position(), daño = 10)
}

class Girasol inherits Planta(image = "girasol.png", costoEnSoles = 50, vida = 5, ticksPorAccion = 20) {

    method generarSol() {
        new Sol(position = self.position()).aparecer()
        efectos.reproducir("solGenerado.mp3")
    }

    override method accionar(manager) {
        self.generarSol()
    }
}

class Nuez inherits Planta(image = "nuez.png", costoEnSoles = 100, vida = 250) {}

// come de a un zombie y después se queda masticando: mientras mastica no puede comer otro
class PlantaCarnivora inherits Planta(image = "plantaCarnivora.png", costoEnSoles = 150, vida = 5, ticksPorAccion = 5) {
    const dañoDeMordida = 100
    const ticksParaMasticar = 18 // 18 ticks de 250 ms = 4,5 segundos
    var ticksMasticando = 0

    method celdasQueCome() = [self.position(), self.position().right(1)]

    method estaMasticando() = ticksMasticando > 0

    // mientras mastica solo descuenta; cuando termina vuelve a funcionar como cualquier planta
    override method pasarTick(manager) {
        if (self.estaMasticando()) {
            ticksMasticando -= 1
        } else {
            super(manager)
        }
    }

    override method accionar(manager) {
        const presas = manager.zombiesEn(self.celdasQueCome())
        if (not presas.isEmpty()) {
            self.comer(presas.first())
        }
    }

    method comer(zombie) {
        zombie.recibirDaño(dañoDeMordida)
        ticksMasticando = ticksParaMasticar
    }
}

// Clase abstracta: cada explosiva dice qué celdas alcanza (celdasAlrededor) y explotar es igual para todas
class PlantaExplosiva inherits Planta {
    const dañoExplosion = 100

    method celdasAlrededor()

    method explotar(manager) {
        manager.dañarZombiesEn(self.celdasAlrededor(), dañoExplosion)
        manager.sacarDelManager(self)
    }

    override method accionar(manager) {
        self.explotar(manager)
    }
}

class Petacereza inherits PlantaExplosiva(image = "petaCereza.png", costoEnSoles = 200, vida = 50, ticksPorAccion = 3) {

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

// es una mina: explota recién cuando un zombie la muerde
class Patapum inherits PlantaExplosiva(image = "patapum.png", costoEnSoles = 50, vida = 50, ticksPorAccion = 3) {
    var fueMordida = false

    override method recibirDaño(cantidad) {
        super(cantidad)
        fueMordida = true
    }

    override method accionar(manager) {
        if (fueMordida) {
            self.explotar(manager)
        }
    }

    override method celdasAlrededor() = [
        self.position(),
        self.position().left(1),
        self.position().right(1)
    ]
}
