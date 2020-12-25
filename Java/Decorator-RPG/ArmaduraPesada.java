
public class ArmaduraPesada extends Decorator {

	public ArmaduraPesada(Personagem newBase) {
		super(newBase);
	}

	public String getDescription() {
		return base1.getDescription() + " Armadura pesada - ";
	}

	public double getVida() {
		return base1.getVida() + 30;
	}
	
	@Override
	public double getPeso() {
		return base1.getPeso() + 55.5;
	}

	@Override
	public double getDefesa() {
		return base1.getDefesa() + 35;
	}
}
