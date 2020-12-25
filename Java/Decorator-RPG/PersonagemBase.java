
public class PersonagemBase implements Personagem {
	
	String genero;
	
	public PersonagemBase(String genero){
		
		if(genero == "m"){
			this.genero = "Masculino";
		}else{
			this.genero = "Feminino";
		}
		
	}

	public String getDescription() {
		return "Personagem " + genero + ":";
	}

	public double getVida() {
		
		if (genero.equalsIgnoreCase("Masculino")){
			return 100;
		}else{
			return 80;
		}
	}
	public double getPeso() {
		
		if (genero.equalsIgnoreCase("Masculino")){
			return 80;
		}else{
			return 45;
		}
	}
	
	public double getAtaque() {
		
		if (genero.equalsIgnoreCase("Masculino")){
			return 50;
		}else{
			return 75;
		}
	}
	
	public double getDefesa() {
		
		if (genero.equalsIgnoreCase("Masculino")){
			return 30;
		}else{
			return 10;
		}
	}

	
	
}
