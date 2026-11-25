import manager.*
import random.*
import tablero.*
import entidades.zombies.*

// Las oleadas son infinitas y cada una es más difícil que la anterior (el juego es de supervivencia).
// La colección de este manager es la cola de zombies que todavía no entraron al tablero.
class Oleadas inherits Manager {
  const managerZombies
  const azar = generadorDeNumeros // en los tests se reemplaza por un dado cargado
  const cadaCuantasOleadasHayHorda = 5
  const ticksMinimosDeDescanso = 50
  const ticksMaximosDeDescanso = 100
  var numeroDeOleada = 0
  var ticksDeDescanso = 0

  method numeroDeOleada() = numeroDeOleada

  // mientras haya zombies en la cola, entra uno por tick; cuando se vacía, se descansa y viene la siguiente
  override method hacerPorTick() {
    if (self.hayEntidades()) {
      self.desencolarZombie()
    } else {
      self.descansarOEmpezarOleada()
    }
  }

  method descansarOEmpezarOleada() {
    if (ticksDeDescanso == 0) {
      self.generarNuevaOleada()
      ticksDeDescanso = azar.numeroEntre(ticksMinimosDeDescanso, ticksMaximosDeDescanso)
    } else {
      ticksDeDescanso -= 1
    }
  }

  method generarNuevaOleada() {
    numeroDeOleada += 1
    if (self.esHorda()) {
      avisoDeHorda.mostrar()
    }
    self.cantidadDeZombies().times({ i => self.agregarEntidad(self.crearZombieAleatorio()) })
  }

  method esHorda() = numeroDeOleada % cadaCuantasOleadasHayHorda == 0

  // entre la oleada y el doble; en las hordas, el doble de eso
  method cantidadDeZombies() {
    const cantidad = azar.numeroEntre(numeroDeOleada, numeroDeOleada * 2)
    return if (self.esHorda()) cantidad * 2 else cantidad
  }

  // al principio solo zombies comunes, después se suman los de cono y más adelante los de cubo
  method tiposDisponiblesSegunOleada() {
    if (numeroDeOleada <= 2) return [{ pos => new Zombie(position = pos) }]
    if (numeroDeOleada <= 4) return [{ pos => new Zombie(position = pos) }, { pos => new ZombieCono(position = pos) }]
    return [{ pos => new Zombie(position = pos) }, { pos => new ZombieCono(position = pos) }, { pos => new ZombieCubo(position = pos) }]
  }

  method crearZombieAleatorio() = azar.unoDe(self.tiposDisponiblesSegunOleada()).apply(self.lugarDeEntrada())

  // entran por la última columna, en cualquier fila de pasto
  method lugarDeEntrada() = game.at(game.width() - 1, azar.numeroEntre(0, tablero.filaDelPanel() - 1))

  method desencolarZombie() {
    const zombie = entidades.first()
    self.sacarEntidad(zombie)
    managerZombies.agregarEntidad(zombie)
    game.addVisual(zombie)
  }
}

// Cartel que avisa que viene una horda y se va solo a los pocos segundos
object avisoDeHorda {
  method position() = game.center()
  method text() = "¡SE ACERCA UNA GRAN HORDA!"
  method textColor() = "FF4040FF"

  method mostrar() {
    game.addVisual(self)
    game.schedule(3000, { self.ocultar() })
  }

  // si la partida ya terminó, game.clear() lo sacó antes
  method ocultar() {
    if (game.hasVisual(self)) {
      game.removeVisual(self)
    }
  }

  // está en el tablero: si el cabezal pasa por arriba, no pasa nada
  method tocadoPorCabezal(cabezal) {}
}
