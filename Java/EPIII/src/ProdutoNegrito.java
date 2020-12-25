
public class ProdutoNegrito extends DecoratorFormatting{
	
	public ProdutoNegrito(Produto newBase) {
		super(newBase);
	}
	
	public String formataParaImpressao(){
		
		return "<span style=\"font-weight:bold\">" + base.formataParaImpressao() + "</span>";

	}

}
