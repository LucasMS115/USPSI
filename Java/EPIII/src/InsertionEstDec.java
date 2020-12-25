
public class InsertionEstDec extends InsertionSort{

	public boolean criterio(Produto x, Produto y) {
		return x.getQtdEstoque() > y.getQtdEstoque();
	}
}
