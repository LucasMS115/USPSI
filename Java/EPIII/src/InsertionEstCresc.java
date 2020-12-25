
public class InsertionEstCresc extends InsertionSort{

	public boolean criterio(Produto x, Produto y) {
		return x.getQtdEstoque() < y.getQtdEstoque();
	}
	
}
