
public class DoIt {
	
	public  static void main(String[] args){
		
		Personagem Mago = new EspadaMedia(new ArmaduraLeve(new Cajado(new PersonagemBase("m"))));
		
		System.out.println("Mago");
		
		System.out.println(Mago.getDescription());
		System.out.println("Vida = " + Mago.getVida());
		System.out.println("Ataque = " + Mago.getAtaque());
		System.out.println("Defesa = " + Mago.getDefesa());
		System.out.println("Peso = " + Mago.getPeso());
		
		System.out.println();
		
		Personagem Ladra = new Adaga(new ArmaduraLeve(new PersonagemBase("f")));
		
		System.out.println("Ladra");
		
		System.out.println(Ladra.getDescription());
		System.out.println("Vida = " + Ladra.getVida());
		System.out.println("Ataque = " + Ladra.getAtaque());
		System.out.println("Defesa = " + Ladra.getDefesa());
		System.out.println("Peso = " + Ladra.getPeso());
	
		System.out.println();
	
		Personagem AnaoGuerreiro = new Marretao(new ArmaduraPesada(new Escudo(new PersonagemBase("m"))));
		
		System.out.println("Anao Guerreiro");
		
		System.out.println(AnaoGuerreiro.getDescription());
		System.out.println("Vida = " + AnaoGuerreiro.getVida());
		System.out.println("Ataque = " + AnaoGuerreiro.getAtaque());
		System.out.println("Defesa = " + AnaoGuerreiro.getDefesa());
		System.out.println("Peso = " + AnaoGuerreiro.getPeso());
		
		System.out.println();
		
		Personagem Clerigo = new Marretao(new ArmaduraPesada(new Escudo(new PersonagemBase("f"))));
		
		System.out.println("Clerigo");
		
		System.out.println(Clerigo.getDescription());
		System.out.println("Vida = " + Clerigo.getVida());
		System.out.println("Ataque = " + Clerigo.getAtaque());
		System.out.println("Defesa = " + Clerigo.getDefesa());
		System.out.println("Peso = " + Clerigo.getPeso());
	
	}
	
	
	
}
