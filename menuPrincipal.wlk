import wollok.game.*
import juego.*
import jugador.*
import tablero.*
import sonidos.*
import historial.*

// Todas las pantallas entienden mostrar(): el juego las trata a todas igual (polimorfismo)

object menuPrincipal {
    const property image = "menuPrincipal.jpeg"
    const property position = game.at(0,0)

    method mostrar() {
        game.addVisual(self)
        keyboard.enter().onPressDo({ self.jugar() }) // aca con la tecla enter pasamos a la pantalla donde seteamos nuestro nombre
    }

    method sonar() {
        musica.poner("menuPrincipal.mp3")
    }

    // con Enter pasamos a pedir el nombre y de ahí al juego
    method jugar() {
        juego.cambiar(pantallaNombre)
    }
}

class Cartel {
    const property position
    const property text
    const property textColor = "FFFFFFFF"
}

object cartelNombre {
    method position() = game.at(4, 3)
    method text() = "Tu nombre: " + jugador.nombre() + "_"
    method textColor() = "FFFF00FF"
}

object pantallaNombre {
    const letras = ["a","b","c","d","e","f","g","h","i","j","k","l","m",
                    "n","o","p","q","r","s","t","u","v","w","x","y","z"]

    method mostrar() {
        jugador.borrarNombre()
        tablero.cubrirDePasto()
        game.addVisual(new Cartel(position = game.at(4, 4), text = "Escribí tu nombre y apretá ENTER"))
        game.addVisual(cartelNombre)
        letras.forEach({ letra =>
            keyboard.letter(letra).onPressDo({ jugador.escribirLetra(letra) })
        })
        keyboard.backspace().onPressDo({ jugador.borrarLetra() })
        keyboard.enter().onPressDo({ self.confirmar() })
        game.errorReporter(cartelNombre)
    }

    // la misma música que el menú: como ya está sonando, sigue sin cortarse
    method sonar() {
        musica.poner("menuPrincipal.mp3")
    }

    method confirmar() {
        jugador.validarNombre()
        juego.cambiar(partida)
    }
}

// El juego es de supervivencia: no se gana. Al terminar se muestra el resultado y las últimas partidas jugadas.
object finDePartida {
    // donde van los carteles del historial (dos columnas, dos filas)
    const lugaresDelHistorial = [game.at(2, 2), game.at(6, 2), game.at(2, 1), game.at(6, 1)]

    method mostrar() {
        tablero.cubrirDePasto()
        game.addVisual(new Cartel(position = game.at(4, 5),
                                  text = "Fin de la partida, " + jugador.nombre() + "!",
                                  textColor = "FF4040FF"))
        game.addVisual(new Cartel(position = game.at(4, 4),
                                  text = "Tu resultado: " + historial.ultimoResultado().puntaje(),
                                  textColor = "FFFF00FF"))
        game.addVisual(new Cartel(position = game.at(4, 3), text = "Partidas jugadas: " + historial.cantidadDePartidas()))
        self.mostrarHistorial()
        game.addVisual(new Cartel(position = game.at(4, 0), text = "ENTER para volver al menú"))
        keyboard.enter().onPressDo({ juego.cambiar(menuPrincipal) })
    }

    method mostrarHistorial() {
        const partidas = historial.ultimasPartidas(lugaresDelHistorial.size())
        partidas.size().times({ i =>
            game.addVisual(new Cartel(position = lugaresDelHistorial.get(i - 1), text = partidas.get(i - 1).texto()))
        })
    }

    // se corta la música de la partida y suena una sola vez el sonido del final
    method sonar() {
        musica.parar()
        efectos.reproducir("derrota.mp3")
    }
}
