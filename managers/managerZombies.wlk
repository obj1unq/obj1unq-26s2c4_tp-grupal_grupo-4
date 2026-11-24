import managers.manager.*


class ManagerZobies inherits Manager {
  var property zombiesMatados = 0
  override method hacerPorCadaEntidad(zombie) {
    //self.checkearColision(entidad)
    if(zombie.puedeMover() and not zombie.tieneQueMorir() and not self.colisionoConPlanta(zombie)){ 
    zombie.moverZombie()
      }else{
        if(self.colisionoConPlanta(zombie)){
          self.colisionConPlanta(zombie)
        }else{ 
          zombiesMatados += 1
          self.sacarDelManager(zombie)}
      }
    

  }
  //colision con planta
  method colisionConPlanta(zombie) {
    const plantaColisionada = self.listaDeColisiones(zombie).filter({entidad => entidad.tipo() == "Planta"}).first()
    zombie.atacar(plantaColisionada)
  }

  method colisionoConPlanta(zombie){
    return not self.listaDeColisiones(zombie).filter({entidad => entidad.tipo() == "Planta"}).isEmpty()
  }
  // consulta para la partida: un zombie que ya no puede avanzar llegó a la casa
  method algunZombieLlegoALaCasa() {
    return Entidades.any({ zombie => zombie.llegoALaCasa() })}

  override method hacerPorTick(){
    //self.hayEntidades()
    
  }

  method zombiesEn(celdas) =
    Entidades.filter({ zombie => celdas.contains(zombie.position()) })

    //metodo para la clase patapum, petacereza y planta carnivora. recibe informacion de las posiciones
}