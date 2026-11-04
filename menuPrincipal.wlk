import wollok.game.*
import juego.*
import jugador.*
import tablero.*

// Todas las pantallas entienden mostrar(): el juego las trata a todas igual (polimorfismo)

object menuPrincipal {
    const property image = "menuPrincipal.png"
    const property position = game.at(0,0)

    method mostrar() {
        game.addVisual(self)
        keyboard.enter().onPressDo({ self.jugar() }) // aca con la tecla enter pasamos a la pantalla donde seteamos nuestro nombre 
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

    method confirmar() {
        jugador.validarNombre()
        juego.cambiar(partida)
    }
}

class PantallaFinal {
    const titulo
    const colorTitulo

    method mostrar() {
        tablero.cubrirDePasto()
        game.addVisual(new Cartel(position = game.at(4, 3),
                                  text = titulo + ", " + jugador.nombre() + "!",
                                  textColor = colorTitulo))
        game.addVisual(new Cartel(position = game.at(4, 2), text = "ENTER para volver al menú"))
        keyboard.enter().onPressDo({ juego.cambiar(menuPrincipal) })
    }
}

object victoria inherits PantallaFinal(titulo = "Ganaste", colorTitulo = "FFFF00FF") {}

object derrota inherits PantallaFinal(titulo = "Perdiste", colorTitulo = "FF4040FF") {}
