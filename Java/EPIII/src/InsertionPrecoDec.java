
public class InsertionPrecoDec extends InsertionSort{

	public boolean criterio(Produto x, Produto y) {
		return x.getPreco() > y.getPreco();
	}
}
