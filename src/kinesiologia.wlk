//TODO nota 2(dos)
//tests: faltan los chequeos por error. fallan 2 tests 
//1) Mal: no usa polimorfismo para saber si puede usar o no el aparato. El polimorfismo de uso es pobre. no chequea error
//2) Regular+ No hace un buen uso de colecciones
//3) Mal: mucho codigo duplicado por no usar super
//4) B+


class Paciente {
	
	var property edad
	var property dolor
	var property fortaleza
	var property rutina = []
	
	method nivelDeDolor(unAparato) {
		 dolor -=  unAparato.efectoEnDolor(self)
	}
	
	method fortalezaMuscular(unAparato) {
		 fortaleza +=   unAparato.efectoEnFortaleza(self)
	}
	
	method puedeUsarAparato(unAparato) {
		//TODO: en lugar de anidar estos ifs, hay que delegar en el aparato y que cada aparato chequee 
		//lo que le interesa. Esta mal que el aparato entienda mensajes "edadMinima" 
		//(porque solo le interesa a la bicicleta)
		//Grave problema de responsabilidad
		
		if (edad >= unAparato.edadMinima() and not unAparato.esMinitramp()) {
			return true
		}  
		
		else ( if(edad >= unAparato.edadMinima() and unAparato.esMinitramp()) {
			return dolor < 20
		}
		
		else return false
			
		)
	}
	
	method usarAparato(unAparato) {
		//TODO: pobre uso de polimorfismo: por cada criterio nuevo que quiera modificar un aparato hay
		// que agregar un método nuevo en todos los demás. La mejor solución es 
		// que el aparato reciba una orden y sea éste el que eliga si mandar los mensajes con efecto.
		
		//TODO: Si se pide usar un aparato que no se puede deberia romper con error
		self.nivelDeDolor(unAparato)
		self.fortalezaMuscular(unAparato)
	}
	
	method puedeHacerLaRutina() {
		//TODO: Si bien cumple el requeriiento, es un mal uso de colecciones. Se resuelve con un all
		//TODO: Por qué convierte a lista para preguntar el tamaño?
		return rutina.filter({aparato => self.puedeUsarAparato(aparato)}).asList().size() == rutina.size()
	}
	
	method hacerRutina() {
		 rutina.forEach({aparato => self.usarAparato(aparato)})
	}
	
	
	
}

class Aparato {   
	
	var property color
	//TODO: mala variable: denota el tipo evitando el uso de polimorfismo
	var property esMinitramp
	
	
	
	method edadMinima() 
	
	method efectoEnDolor(unPaciente)
	
	method efectoEnFortaleza(unPaciente)
}

class Magneto inherits Aparato{
	
	override method edadMinima() {
		return 0
	}
	
	override method efectoEnDolor(unPaciente) {
		return unPaciente.dolor() * 0.1
	}
	
	override 	method efectoEnFortaleza(unPaciente) {
		return 0
	}
	

	
	
}

class Bicicleta inherits Aparato {
	

 override   method efectoEnDolor(unPaciente) {
   	return   4
   }
   
  override  method efectoEnFortaleza(unPaciente) {
   	return  3
   }
   
   override method edadMinima() {
		return 8
	}
	

 	
}


class Minitramp inherits Aparato {

 override  method efectoEnFortaleza(unPaciente) {
  	if(unPaciente.dolor() < 20) {
  		 return unPaciente.edad() * 0.1
  	}
  	
  	else  return 0  
  	}
  
  override   method efectoEnDolor(unPaciente) {
   	return   0
   }
   
   override method edadMinima() {
		return 0
	}
	
	
  
	
}


class Resistente inherits Paciente {
	
	override method fortalezaMuscular(unAparato) {
		//Suma dos veces el efecto de la fortaleza, la linea despues de super deberia ser fortaleza+=rutina.size()
		super(unAparato) fortaleza +=    unAparato.efectoEnFortaleza(self)  + rutina.size()
	}
	
	
	
}

class Caprichoso inherits Paciente {
	
	method quiereHacerLaRutina() {
		return rutina.any({aparato => aparato.color() == "rojo"})
	}
	
	//aca queria usar SUPER() para no repetir cogido pero me daba un error
	
	override method puedeHacerLaRutina() {
		//TODO: DUPLICA CODIGO! usar super
		return rutina.filter({aparato => self.puedeUsarAparato(aparato)}).asList().size() == rutina.size()
	     and self.quiereHacerLaRutina()
	    
	
	}
	
	override method hacerRutina() {
		//TODO: DUPLICA CODIGO! usar super
		 rutina.forEach({aparato => self.usarAparato(aparato)})
		 rutina.forEach({aparato => self.usarAparato(aparato)})
	}
	
}

class Rapidarecuperacion inherits Paciente {
	
	
	//TODO: no cumple requerimiento: debe restar un valor configurable de dolor
	override method hacerRutina() {
		//TODO esta haciendo la rutina dos veces
		 rutina.forEach({aparato => self.usarAparato(aparato)})
		 super() dolor = 3
	}
	
	
}

class Centro {
	
	var aparatos = #{}
	var pacientes = #{}
	
		method coloresDeAparatos() {
			return aparatos.map({aparato => aparato.color()}).asSet()
		}
		
		method pacientesMenores() {
			return pacientes.filter({paciente => paciente.edad() < 8}).asSet()
		}
		
		method pacientesQueNoPuedenCumplirLaSesion() {
			//TODO: mas directo usar un count
			return pacientes.filter({paciente => not paciente.puedeHacerLaRutina()}).size()
		}
		
		
	 
}

































