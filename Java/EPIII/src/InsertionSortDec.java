
public class InsertionSortDec extends InsertionSort{

	public boolean criterio(Produto x, Produto y) {
		return x.getDescricao().compareToIgnoreCase(y.getDescricao()) > 0;
	}
}
