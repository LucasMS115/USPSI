
public class FiltroQtdEst extends Filtro{
	
	public boolean criterio(Object argFiltro, Produto p) {
		return p.getQtdEstoque() <= (Integer) argFiltro;
	}

	public FiltroQtdEst(int argFiltro) {
		this.argFiltro = argFiltro;
	}
	
}
