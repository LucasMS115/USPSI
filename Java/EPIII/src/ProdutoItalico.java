
public class ProdutoItalico extends DecoratorFormatting{
	
	public ProdutoItalico(Produto newBase) {
		super(newBase);
	}
	
	public String formataParaImpressao(){
		
		return "<span style=\"font-style:italic\">" + base.formataParaImpressao() + "</span>";

	}

}
