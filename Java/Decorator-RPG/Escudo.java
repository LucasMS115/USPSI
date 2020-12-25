
public class Escudo extends Decorator{

	public Escudo(Personagem newBase) {
		super(newBase);
	}

	public String getDescription() {
		return base1.getDescription() + " Escudo - ";
	}
	
	@Override
	public double getPeso() {
		return base1.getPeso() + 25;
	}

	@Override
	public double getAtaque() {
		return base1.getAtaque() - 15;
	}
	
	public double getDefesa(){
		return base1.getDefesa() + 40;
	}
	
}
