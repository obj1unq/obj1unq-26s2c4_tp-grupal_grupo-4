// Un manager tiene una colección de entidades y les dice qué hacer en cada tick.
// tick() es un template method: el algoritmo es siempre el mismo y cada manager completa los dos pasos (hooks).
class Manager {
  // la colección no se expone: se agregan y sacan entidades pidiéndoselo al manager
  const entidades = []

  method agregarEntidad(entidad) {
    entidades.add(entidad)
  }

  method hayEntidades() = not entidades.isEmpty()

  method sacarEntidad(entidad) {
    entidades.remove(entidad)
  }

  method sacarDelManager(entidad) {
    game.removeVisual(entidad)
    self.sacarEntidad(entidad)
  }

  method tick() {
    self.hacerPorTick()
    // se recorre una copia porque en el camino se pueden sacar entidades (zombies muertos, proyectiles que pegaron)
    entidades.copy().forEach({ entidad => self.hacerPorCadaEntidad(entidad) })
  }

  // hooks con comportamiento por defecto: no hacer nada. Cada manager redefine solo el que necesita
  method hacerPorTick() {}
  method hacerPorCadaEntidad(entidad) {}
}
