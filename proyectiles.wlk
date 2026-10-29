import zombies.*

class Proyectil {
  var property position
  var property image 
  var property daño  

    method moverse() {
    game.onCollideDo(self, { elemento =>
        self.impactoZombie(elemento)
    })
    game.onTick(3000, "movimientoGuisante", {=> self.movimiento()})
    }

    method movimiento(){
        position = position.right(1)
    }

    method registrarimpacto(){
        game.onCollideDo(self, {elemento => self.impactoZombie(elemento)})
    }

    method impactoZombie(zombie){
        if (zombie.esZombie()){
            zombie.recibirDaño(self.daño())
            self.impacto()
        }
    }

    method impacto(){
        game.removeVisual(self)
    }
}