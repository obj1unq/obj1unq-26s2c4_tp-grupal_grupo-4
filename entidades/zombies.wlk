import entidades.entidad.*
import sonidos.*

class Zombie inherits Mob(image = "zombie.png", vida = 10, position = game.at(0, 0)) {
  const ticksPorPaso = 10 // cuántos ticks tarda en dar un paso: más alto, más lento
  const daño = 10
  var ticksDesdeElUltimoPaso = 0

  // orden: pasa un tick y, si ya le toca, da un paso
  method pasarTick() {
    ticksDesdeElUltimoPaso += 1
    if (self.leTocaCaminar()) {
      self.caminar()
    }
  }

  // consulta: solo pregunta, no cambia nada
  method leTocaCaminar() = ticksDesdeElUltimoPaso >= ticksPorPaso

  method caminar() {
    position = position.left(1)
    ticksDesdeElUltimoPaso = 0
  }

  method atacar(planta) {
    efectos.reproducir("zombiesComiendo.mp3")
    planta.recibirDaño(daño)
  }

  // lo toca un proyectil: suena el impacto y el proyectil hace su efecto (daño, frío...)
  method recibirProyectil(proyectil) {
    efectos.reproducir("impacto.mp3")
    proyectil.aplicarEfecto(self)
  }

  method ralentizar() {
    game.say(self, "Hace frío")
    self.retroceder()
  }

  method retroceder() {
    if (position.x() > 0) {
      position = position.right(1)
    }
  }

  // la casa está a la izquierda del tablero
  method llegoALaCasa() = position.x() < 0
}

class ZombieCono inherits Zombie(image = "zombie_cono.png", vida = 20) {}

class ZombieCubo inherits Zombie(image = "zombie_cubo.png", vida = 30) {}
