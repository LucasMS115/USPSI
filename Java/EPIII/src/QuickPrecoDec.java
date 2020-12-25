
public class QuickPrecoDec extends QuickSort{

	public boolean criterio1(Produto w, Produto x) {
		return w.getPreco() < x.getPreco();
	}
	
	public boolean criterio2(Produto w, Produto x) {
		return w.getPreco() > x.getPreco();
	}

}
