
public class FiltroCategoria extends Filtro{

	public boolean criterio(Object argFiltro, Produto p) {
		return p.getCategoria().equalsIgnoreCase((String)argFiltro);
	}

	public FiltroCategoria(String argFiltro) {
		this.argFiltro = argFiltro;
	}
}
