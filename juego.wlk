import wollok.game.*
import entidades.zombies.*
import entidades.plantas.*
import tablero.*
import jugador.*
import cabezal.*
import menuPrincipal.*

//Todos los manager
import managers.managerZombies.ManagerZobies
import managers.managerOleadas.Oleadas
import managers.managerProyectiles.ManagerProyectiles
import managers.managerPlantas.ManagerPlantas
import managers.managerDeSoles.ManagerDeSoles

object juego {

    method configurar() {
        game.title("Plantas vs Zombies")
        game.height(6) // 5 filas de pasto + 1 de panel
        game.width(9)
        game.cellSize(100)
        self.cambiar(menuPrincipal)
    }

    // Cada pantalla (menuPrincipal, pantallaNombre, partida, victoria, derrota) entiende mostrar().
    // El juego no pregunta cuál es: limpia todo y le dice que se muestre (polimorfismo).
    method cambiar(pantalla) {
        game.clear()
        pantalla.mostrar()
    }

    // se llama desde adentro de un tick: se espera a que ese tick termine antes de limpiar todo
    method terminar(pantallaFinal) {
        game.schedule(1, { self.cambiar(pantallaFinal) })
    }
}

object partida {
    var property managerProyectiles = null
    var property managerZombies = null
    var property managerPlantas = null
    var property oleada = null
    var property managerDeSoles = null
    method mostrar() {
        jugador.reiniciarSoles()
        // primero hay que dibujar el tablero para que no pise a las plantas y a los zombies visualmente
        tablero.dibujarTablero()
        self.crearManagers()
        self.agregarEntidadesIniciales()
        cabezal.configurar()
        self.programarTicks()
    }

    method crearManagers() {
        managerProyectiles = new ManagerProyectiles()
        managerZombies = new ManagerZobies()
        managerPlantas = new ManagerPlantas(managerDeProyectiles = managerProyectiles, managerDeZombies = managerZombies) // agregado para que funcionen las nuevas clases
        oleada = new Oleadas(managerZombies = managerZombies)
        managerDeSoles = new ManagerDeSoles()
    }

    method agregarEntidadesIniciales() {
        const nuez1 = new Nuez (position = game.at(7,3))
        const girasol1 = new Girasol (position = game.at(0,2))
        const lanzaguisante1 = new LanzaGuisante (position = game.at(1  ,2))

        const zombie1 = new Zombie(position = game.at(8,3), velocidad= 1, daño = 10)
        oleada.agregarCantidadEntidad(3, {i=> new Zombie(position = game.at(1,0), velocidad = i+3, daño = 10)})
        managerZombies.agregarEntidad(zombie1)
        managerPlantas.agregarEntidad(lanzaguisante1)
        managerPlantas.agregarEntidad(girasol1)
        managerPlantas.agregarEntidad(nuez1)
        game.onTick(5000, "generarSol", {girasol1.generarSol()})

        game.addVisual(lanzaguisante1)
        game.addVisual(zombie1)
        game.addVisual(girasol1)
        game.addVisual(nuez1)
    }

    method programarTicks() {
        game.onTick(500, "tickProyectil", {managerProyectiles.tick()})
        game.onTick(5000,"Generar Zombie", {oleada.tick()})
        game.onTick(1500, "tickZombie", {managerZombies.tick()})
        game.onTick(1000, "tickPlantas", {managerPlantas.tick()})
        // por ahora los soles suben solos
        game.onTick(3000, "solesAutomaticos", {managerDeSoles.tick()})
        // cada 1000 ms: más seguido que el tick de zombies (1500 ms), así no se escapa uno que llegó a la casa
        game.onTick(1000, "chequearFinDelJuego", {self.chequearFinDelJuego()})
    }

    // FIN DEL JUEGO: la partida pregunta, los managers no necesitan conocerla
    method perdioElJugador() = managerZombies.algunZombieLlegoALaCasa()

    method ganoElJugador() = not oleada.hayEntidades() and not managerZombies.hayEntidades()

    method chequearFinDelJuego() {
        if (self.perdioElJugador()) {
            juego.terminar(derrota)
        } else if (self.ganoElJugador()) {
            juego.terminar(victoria)
        }
    }
}
