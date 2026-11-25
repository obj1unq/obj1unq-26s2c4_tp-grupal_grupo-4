import wollok.game.*
import tablero.*
import jugador.*
import cabezal.*
import menuPrincipal.*
import sonidos.*
import historial.*

//Todos los manager
import managers.managerZombies.ManagerZombies
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
        // se espera a que el juego arranque (game.start()): antes de eso Wollok no deja reproducir sonidos
        game.schedule(1, { self.cambiar(menuPrincipal) })
    }

    // Cada pantalla (menuPrincipal, pantallaNombre, partida, finDePartida) entiende mostrar() y sonar().
    // El juego no pregunta cuál es: limpia todo y le dice que se muestre y que suene (polimorfismo).
    method cambiar(pantalla) {
        game.clear()
        pantalla.mostrar()
        pantalla.sonar()
    }

    // se llama desde adentro de un tick: se espera a que ese tick termine antes de limpiar todo
    method terminar(pantallaFinal) {
        game.schedule(1, { self.cambiar(pantallaFinal) })
    }
}

object partida {
    // se crean de nuevo en cada partida (crearManagers). Desde afuera solo se consultan
    var managerProyectiles = null
    var managerZombies = null
    var managerPlantas = null
    var oleada = null
    var managerDeSoles = null

    method managerZombies() = managerZombies
    method managerPlantas() = managerPlantas
    method managerProyectiles() = managerProyectiles
    method oleada() = oleada

    // un solo tick para todo el juego, así el orden es siempre el mismo
    method tick() {
        oleada.tick()             // 1. si hay zombies en la cola, entra uno al tablero
        managerPlantas.tick()     // 2. las plantas actúan (disparan, generan soles, explotan...)
        managerProyectiles.tick() // 3. los proyectiles avanzan o le pegan a un zombie
        managerZombies.tick()     // 4. los zombies mueren, comen o caminan
        managerDeSoles.tick()     // 5. cada tanto cae un sol
        self.chequearFinDelJuego() // 6. ¿algún zombie llegó a la casa?
    }

    method mostrar() {
        jugador.reiniciarSoles()
        // primero hay que dibujar el tablero para que no pise a las plantas y a los zombies visualmente
        tablero.dibujarTablero()
        self.crearManagers()
        cabezal.configurar()
        self.programarTicks()
    }

    method sonar() {
        musica.poner("musicaPartida.mp3")
    }
    method zombiesMatados() = managerZombies.zombiesMatados()

    // cada manager recibe al crearse los otros managers que necesita
    method crearManagers() {
        managerZombies = new ManagerZombies()
        managerProyectiles = new ManagerProyectiles(managerDeZombies = managerZombies)
        managerPlantas = new ManagerPlantas(managerDeProyectiles = managerProyectiles, managerDeZombies = managerZombies)
        oleada = new Oleadas(managerZombies = managerZombies)
        managerDeSoles = new ManagerDeSoles()
    }

    method programarTicks() {
        game.onTick(250, "mastertick", { self.tick() })
    }

    // FIN DEL JUEGO: es de supervivencia, no se gana. La partida termina cuando un zombie llega a la casa
    method perdioElJugador() = managerZombies.algunZombieLlegoALaCasa()

    method chequearFinDelJuego() {
        if (self.perdioElJugador()) {
            self.finalizar()
        }
    }

    // se guarda el resultado en el historial y se pasa a la pantalla final
    method finalizar() {
        historial.registrar(self.resultado())
        juego.terminar(finDePartida)
    }

    method resultado() = new Resultado(nombre = jugador.nombre(),
                                       zombiesMatados = self.zombiesMatados(),
                                       oleada = self.oleadaAlcanzada())

    method oleadaAlcanzada() = oleada.numeroDeOleada()
}
