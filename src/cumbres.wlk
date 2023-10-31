import paises.*
import participantes.*
import conocimientos.*

object cumbre {
	const property paisesAuspiciantes = #{}
	const personas = #{}
	const actividades = #{}
	var property commitsParaIngreso = 300

	
	method registrarAuspiciante(unPais){
		paisesAuspiciantes.add(unPais)
	}
	
	method paisConflictivo(unPais){
		return unPais.paisesConConflicto().intersection(paisesAuspiciantes).size() > 0
	}
	
	method registrarIngreso(unaPersona){
		personas.add(unaPersona)
	}
	
	method darIngreso(unaPersona){
		if(not self.puedeIngresar(unaPersona)){
			self.error("El participante no puede ingresar a la cumbre")
		}
		self.registrarIngreso(unaPersona)
	}
	
	method puedeIngresar(unaPersona){
		return unaPersona.cumpleCondicionIngreso() and not self.esRestringida(unaPersona)
	}
	
	method esRestringida(unaPersona){
		return self.esDePaisConflictivo(unaPersona) or self.cupoDeSuPaisLleno(unaPersona)
	}
	
	method esDePaisConflictivo(unaPersona){
		return self.paisConflictivo(unaPersona.pais())
	}
	
	method cupoDeSuPaisLleno(unaPersona){
		return not self.esDePaisAuspiciante(unaPersona) and self.participantesDeUnPais(unaPersona.pais()) >= 2
	}
	
	method esDePaisAuspiciante(unaPersona){
		return paisesAuspiciantes.contains(unaPersona.pais())
	}
	
	method paisesDeParticipantes(){
		return personas.map({pers => pers.pais()}).asSet()
	}
	
	method participantesDeUnPais(unPais){
		return personas.count({pers => pers.pais() == unPais})
	}
	
	method paisConMasParticipantes(){
		return self.paisesDeParticipantes().max({pais => self.participantesDeUnPais(pais)})
	}
	
	method participantesExtranjeros(){
		return personas.filter({pers => not paisesAuspiciantes.contains(pers.pais())})
	}
	
	method esRelevante(){
		return personas.all({pers => pers.esCape()})
	}
	
	method esSegura(){
		return personas.all({pers => self.puedeIngresar(pers)})
	}
	
	method registrarActividad(unaActividad){
		actividades.add(unaActividad)
	}
	
	method totalDeHorasActividades(){
		return actividades.sum({act => act.horas()})
	}
}
