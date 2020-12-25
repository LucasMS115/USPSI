
public class FiltroContem extends Filtro{
	
	public boolean criterio(Object argFiltro, Produto p) {
		return p.getDescricao().toLowerCase().contains((String) argFiltro) ;
	}

	public FiltroContem(String argFiltro) {
		this.argFiltro = argFiltro.toLowerCase();
	}
	
}
