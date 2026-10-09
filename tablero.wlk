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