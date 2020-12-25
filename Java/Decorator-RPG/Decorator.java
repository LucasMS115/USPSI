
public class Decorator implements Personagem{
	
	protected Personagem base1;
	
	public Decorator (Personagem newBase){
		base1 = newBase;
	} 

	@Override
	public String getDescription() {
		return base1.getDescription();
	}

	@Override
	public double getVida() {
		return base1.getVida();
	}

	@Override
	public double getPeso() {
		return base1.getPeso();
	}

	@Override
	public double getAtaque() {
		return base1.getAtaque();
	}

	@Override
	public double getDefesa() {
		return base1.getDefesa();
	}
	
	
}
