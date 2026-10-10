<<<<<<< HEAD
class Celda { 
    const property x 
    const property y 
    var property 
    ocupante = null // Almacena la planta u objeto en la celda 
    method position() = game.at(x, y) 
    method estaOcupada() = ocupante != null 
    method vaciar() { 
        ocupante = null } } 
object tablero { 
    const property ancho = 9 // 9 columnas (de 0 a 8) 
    const property alto = 5 // 5 lineas/filas (de 0 a 4) 
    const celdas = [] // Genera dinámicamente la matriz de celdas 
    method inicializar() {
         celdas.clear() (0 .. ancho - 1).forEach({ x =>(0 .. alto - 1).forEach({ y => celdas.add(new Celda(x = x, y = y)) }) }) } 
         // Busca y devuelve la celda en las coordenadas (x, y) 
    method celdaEn(x, y) { return celdas.find({ celda => celda.x() == x and celda.y() == y }) }
          // Verifica si las coordenadas pertenecen al tablero 
    method esPosicionValida(x, y) { 
            return x.between(0, ancho - 1) and y.between(0, alto - 1) 
            }
    }
=======
import wollok.game.*

class CeldaPasto {
    var property position
    method image() = "pasto.jpg"
}

object tablero {

    // TAREA GENERAL: Recorre las filas de abajo hacia arriba
    method dibujarTablero() {
        (0 .. game.height() - 1).forEach({ y => 
            self.crearFilaCompleta(y) 
        })
    }

    // SUBTAREA 1: Camina horizontalmente por toda esa fila poniendo los bloques
    method crearFilaCompleta(y) {
        (0 .. game.width() - 1).forEach({ x => 
            self.ponerPastoEn(x, y) 
        })
    }

    // SUBTAREA 2: Crea el objeto visual y lo agrega al juego
    method ponerPastoEn(x, y) {
        const pasto = new CeldaPasto(position = game.at(x, y))
        game.addVisual(pasto)
    }
}

>>>>>>> origin/master
