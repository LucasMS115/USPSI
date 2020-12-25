
public class FiltroIntervalo extends Filtro{
	
	double[] inter;
	
	public boolean criterio(Object argFiltro, Produto p) {
		return p.getPreco() >= this.inter[0] && p.getPreco() <= this.inter[1];
	}

	public FiltroIntervalo(double[] inter) {
		this.inter = inter;
	}
	
}
