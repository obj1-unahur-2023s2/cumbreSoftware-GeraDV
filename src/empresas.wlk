import paises.*

class Empresa {
	const paises = #{}
	
	method esMultinacional(){
		return paises.size() >= 3
	}
}
