// El juego es de supervivencia: no se gana, se juega para llegar lo más lejos posible.
// Cada partida que termina deja un resultado, y el historial los guarda mientras el juego esté abierto.

class Resultado {
    const nombre
    const zombiesMatados
    const oleada

    method puntaje() = zombiesMatados.toString() + " zombies, oleada " + oleada

    method texto() = nombre + ": " + self.puntaje()
}

object historial {
    const resultados = []

    method registrar(resultado) {
        resultados.add(resultado)
    }

    method cantidadDePartidas() = resultados.size()

    method ultimoResultado() = resultados.last()

    // en la pantalla entran pocos carteles: se muestran las partidas más recientes
    method ultimasPartidas(cantidad) = resultados.reverse().take(cantidad)
}
