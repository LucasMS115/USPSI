
public class Adaga extends Decorator {
	
	public Adaga(Personagem newBase) {
		super(newBase);
	}

	
	public String getDescription() {
		return base1.getDescription() + " Adaga ";
	}
	
	@Override
	public double getPeso() {
		return base1.getPeso() + 0.7;
	}

	@Override
	public double getAtaque() {
		return base1.getAtaque() + 50;
	}


}
