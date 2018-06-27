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
		self.nivelDeDolor(unAparato)
		self.fortalezaMuscular(unAparato)
	}
	
	method puedeHacerLaRutina() {
		return rutina.filter({aparato => self.puedeUsarAparato(aparato)}).asList().size() == rutina.size()
	}
	
	method hacerRutina() {
		 rutina.forEach({aparato => self.usarAparato(aparato)})
	}
	
	
	
}

class Aparato {   
	
	var property color
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
		super(unAparato) fortaleza +=    unAparato.efectoEnFortaleza(self)  + rutina.size()
	}
	
	
	
}

class Caprichoso inherits Paciente {
	
	method quiereHacerLaRutina() {
		return rutina.any({aparato => aparato.color() == "rojo"})
	}
	
	//aca queria usar SUPER() para no repetir cogido pero me daba un error
	
	override method puedeHacerLaRutina() {
		return rutina.filter({aparato => self.puedeUsarAparato(aparato)}).asList().size() == rutina.size()
	     and self.quiereHacerLaRutina()
	    
	
	}
	
	override method hacerRutina() {
		 rutina.forEach({aparato => self.usarAparato(aparato)})
		 rutina.forEach({aparato => self.usarAparato(aparato)})
	}
	
}

class Rapidarecuperacion inherits Paciente {
	
	
	
	override method hacerRutina() {
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
			return pacientes.filter({paciente => not paciente.puedeHacerLaRutina()}).size()
		}
		
		
	 
}

































