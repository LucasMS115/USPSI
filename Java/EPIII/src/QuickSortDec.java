
public class QuickSortDec extends QuickSort{
		
	public boolean criterio1(Produto w, Produto x) {
		return w.getDescricao().compareToIgnoreCase(x.getDescricao()) < 0;
	}
	
	public boolean criterio2(Produto w, Produto x) {
		return w.getDescricao().compareToIgnoreCase(x.getDescricao()) > 0;
	}

}
