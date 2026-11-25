import wollok.game.*

// MÚSICA DE FONDO: suena una sola a la vez y en loop
object musica {
    var sonando = silencio
    var archivoSonando = ""

    // si ya suena ese archivo no hace nada: así el menú y la pantalla del nombre comparten la música sin cortarla
    method poner(archivo) {
        if (archivo != archivoSonando) {
            self.parar()
            sonando = game.sound(archivo)
            sonando.shouldLoop(true)
            sonando.volume(0.3) // más baja que los efectos, para que se escuchen
            sonando.play()
            archivoSonando = archivo
        }
    }

    method parar() {
        sonando.stop()
        sonando = silencio
        archivoSonando = ""
    }
}

// objeto nulo: es "la música" cuando no suena nada, así parar() no tiene que preguntar si hay algo sonando
object silencio {
    method stop() {}
}

// EFECTOS: suenan una vez. Un sonido de Wollok no se puede reproducir dos veces, por eso se crea uno nuevo cada vez
object efectos {
    method reproducir(archivo) {
        game.sound(archivo).play()
    }
}
