
public class EspadaMedia extends Decorator {

	public EspadaMedia(Personagem newBase) {
		super(newBase);
	}
	
	public String getDescription() {
		return base1.getDescription() + " Espada Media";
	}
	
	@Override
	public double getPeso() {
		return base1.getPeso() + 3;
	}

	@Override
	public double getAtaque() {
		return base1.getAtaque() + 40;
	}
	
	public double getDefesa(){
		return base1.getDefesa() + 5;
	}

}
