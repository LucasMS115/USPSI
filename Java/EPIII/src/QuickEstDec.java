
public class QuickEstDec extends QuickSort{


	public boolean criterio1(Produto w, Produto x) {
		return w.getQtdEstoque() < x.getQtdEstoque();
	}
	
	public boolean criterio2(Produto w, Produto x) {
		return w.getQtdEstoque() > x.getQtdEstoque();
	}

}
