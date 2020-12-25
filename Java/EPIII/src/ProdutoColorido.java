import java.awt.Color;

public class ProdutoColorido extends DecoratorFormatting{
	Color cor;
	
	public ProdutoColorido(Produto newBase, Color cor) {
		super(newBase);
		this.cor = cor;
	}
	

	public String formataParaImpressao(){ 
		return "<span style=color:rgb(" + cor.getRed() + "," + cor.getGreen() + "," + cor.getBlue()+ ")>" + base.formataParaImpressao() + "</span>";

	}

}
