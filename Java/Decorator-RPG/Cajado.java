
public class Cajado extends Decorator {

	public Cajado(Personagem newBase) {
		super(newBase);
	}
	
	public String getDescription() {
		return base1.getDescription() + " Cajado - ";
	}
	
	@Override
	public double getPeso() {
		return base1.getPeso() + 0.5;
	}

	@Override
	public double getAtaque() {
		return base1.getAtaque() + 35;
	}
	
	public double getVida(){
		return base1.getDefesa() - 10;
	}
	
}
