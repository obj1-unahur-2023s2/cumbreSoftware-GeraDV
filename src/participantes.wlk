import conocimientos.*
import paises.*
import cumbres.*
import actividades.*
import empresas.*

class Participante {
	const property pais
	const property conocimientos = #{}
	var commits = 0
	
	method commits() = commits
	
	method esCape()
	
	method cumpleCondicionIngreso(){
		return conocimientos.contains(programacionBasica)
	}
	
	method agregarConocimiento(unConocimiento){
		conocimientos.add(unConocimiento)
	}
	
	method agregarCommits(unaCantidad){
		commits += unaCantidad
	}
	
	method realizarActividad(unaActividad){
		self.agregarConocimiento(unaActividad.tema())
		self.agregarCommits(unaActividad.tema().commitsPorHora() * unaActividad.horas())
	}
}

class Programador inherits Participante{
	var horasDeCapacitacion = 0
	
	method horasDeCapacitacion() = horasDeCapacitacion
	
	override method esCape() = commits > 500
	
	override method cumpleCondicionIngreso(){
		return super() and commits >= cumbre.commitsParaIngreso()
	}
	
	override method realizarActividad(unaActividad){
		super(unaActividad)
		horasDeCapacitacion += unaActividad.horas()
	}
}

class Especialista inherits Participante{
	override method esCape() = conocimientos.size() > 2
	
	override method cumpleCondicionIngreso(){
		return super() and commits >= cumbre.commitsParaIngreso()-100 and conocimientos.contains(objetos)
	}
}

class Gerente inherits Participante{
	var empresa
	
	override method esCape() = empresa.esMultinacional()
	
	override method cumpleCondicionIngreso(){
		return super() and conocimientos.contains(manejoDeGrupos)
	}
}
