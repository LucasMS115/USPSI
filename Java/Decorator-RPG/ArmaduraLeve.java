
public class ArmaduraLeve extends Decorator{

	public ArmaduraLeve(Personagem newBase) {
		super(newBase);
	}
	
	public String getDescription() {
		return base1.getDescription() + " Armadura leve - ";
	}

	public double getVida() {
		return base1.getVida() + 10;
	}
	
	@Override
	public double getPeso() {
		return base1.getPeso() + 20.5;
	}

	/*@Override
	public double getAtaque() {
		return base1.getAtaque() + 5;
	}*/

	@Override
	public double getDefesa() {
		return base1.getDefesa() + 10;
	}
	
}
