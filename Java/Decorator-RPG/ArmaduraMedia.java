
public class ArmaduraMedia extends Decorator{

	public ArmaduraMedia(Personagem newBase) {
		super(newBase);
	}
	
	public String getDescription() {
		return base1.getDescription() + " Armadura media - ";
	}

	public double getVida() {
		return base1.getVida() + 15;
	}
	
	@Override
	public double getPeso() {
		return base1.getPeso() + 30.5;
	}

	@Override
	public double getDefesa() {
		return base1.getDefesa() + 20;
	}
	
}
