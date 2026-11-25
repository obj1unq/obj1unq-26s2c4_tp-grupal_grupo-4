// Todo lo que es al azar pasa por acá. En los tests se reemplaza por un objeto que entienda
// los mismos mensajes pero devuelva siempre lo mismo (un "dado cargado"), así los tests son repetibles.
object generadorDeNumeros {
    method numeroEntre(minimo, maximo) = (minimo .. maximo).anyOne()

    method unoDe(lista) = lista.anyOne()
}
