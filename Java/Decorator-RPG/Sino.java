
public class Sino extends Decorator{

	public Sino(Personagem newBase) {
		super(newBase);
	}
	
	public String getDescription() {
		return base1.getDescription() + " Sino - ";
	}
	
	@Override
	public double getPeso() {
		return base1.getPeso() + 0.9;
	}

	@Override
	public double getAtaque() {
		return base1.getAtaque() + 10;
	}
	
	public double getVida(){
		return base1.getDefesa() + 20;
	}
	

}
