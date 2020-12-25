
public class Marretao extends Decorator{

	public Marretao(Personagem newBase) {
		super(newBase);
	}

	public String getDescription() {
		return base1.getDescription() + " Marretao";
	}
	
	@Override
	public double getPeso() {
		return base1.getPeso() + 15;
	}

	@Override
	public double getAtaque() {
		return base1.getAtaque() + 60;
	}
	
	public double getDefesa(){
		return base1.getDefesa() + 15;
	}
	
}
