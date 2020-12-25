import java.sql.*;
import java.util.Scanner;

public class Agenda{
	
	Scanner scan = new Scanner(System.in);
	
	Connection conexao = null; //relacionada ao modulo de conexao
    PreparedStatement pst = null; //prepara a conexao com o banco
    ResultSet rs = null; // exibe os resultados
    
    public int contador = 0;
	
	public Contatos contatos[];
	
	public Agenda() {
		contatos = new Contatos[5];
        conexao = ModuloConexao.conector();
        Atualizar();
	}
	
	public void addContato(Contatos c) throws AgendaCheiaException {
		
		boolean cheia = true;
		
		for (int i = 0; i< contatos.length; i++) {
			
			if(contatos[i] == null) {
				contatos[i] = c;
				System.out.println("Insira o NOME:");
				c.setNome(scan.nextLine());
				
				System.out.println("Insira o TELEFONE:");
				c.setTelefone(scan.nextLine());
				
				System.out.println("Insira o E-MAIL:");
				c.setEMail(scan.nextLine());
				
				c.setId(i);
				cheia = false;
				
				//-----------------------------------------------------------------------------------------------------
				
				String sql = "insert into tbContatos(tipo, nome, telefone, eMail, idContato) values(?,?,?,?,?)";
				try {
		            pst = conexao.prepareStatement(sql);
		            pst.setString(1,c.getTipo());
		            pst.setString(2, c.getNome());
		            pst.setString(3,c.getTelefone());
		            pst.setString(4, c.getEMail());
		            pst.setInt(5, c.getId());
		            
		            int adicionado = pst.executeUpdate();
		            
		            if(adicionado > 0){
						contador ++;
		               System.out.println("Salvando...");
		            } 
		            
				 } catch (Exception e) {
			            System.out.println(e);
			     } 
				
				//-----------------------------------------------------------------------------------------------------
				
				break;
			}
		}
		
		if (cheia == true) {
			throw new AgendaCheiaException();
		}
		
	}
	
	public Contatos consulta(int id) throws ContatoNaoEncontradoException {
		
		for (int i = 0; i<contatos.length; i++) {
			if (contatos[i] != null) {
				if(contatos[i].getId() == id) {
					return contatos[i];
				}
			}
		}
		
		throw new ContatoNaoEncontradoException(id);
	}
	
	public Contatos consulta(String nome) throws ContatoNaoEncontradoException{
		for (int i = 0; i<contatos.length; i++) {
			if (contatos[i] != null) {
				if(contatos[i].getNome().equalsIgnoreCase(nome)) {
					return contatos[i];
				}
			}
		}
		
		throw new ContatoNaoEncontradoException(nome);
	}
	
	public String toString() {
		
		String s = "[ ";
		
		for (int i = 0; i < contatos.length; i++) {
			s += contatos[i] + "\n";
		}
		
		s += "]";
		
		return s;
	}
	
	public void Atualizar() {	
		
		String tp,n,t,eM;
		
	    for(int i = 0; i < contatos.length; i++) {
	    	
	    	String sql = "select * from tbContatos where idContato=?";
      
	        try {
	        	pst = conexao.prepareStatement(sql);
	        	pst.setLong(1,i);
	            rs = pst.executeQuery();
	            
	            if (rs.next()) {
	            	
	            	tp = rs.getString(2);
	            	n = rs.getString(3);
	            	t = rs.getString(4);
	            	eM = rs.getString(5);
	            	
	            	Contatos c = new Contatos(contador,n,t,eM);
	            	
	            	contatos[i] = c;
	            	contador++;
	            	
	            } else {
	            }
	            
	        } catch (Exception e) {
	        }
	        
	    }	
		
        System.out.println("Olá\n"+"Agenda atual possui " + contador + " contatos!");
	    
	}
	
	public void Deletar(int id) {
		if(contatos[id] != null) {
			try {
				System.out.println("Deletando " + contatos[id]);
				contatos[id] = null;
				
				String sql = "delete from tbContatos where idContato=?";
	            try {
	                pst = conexao.prepareStatement(sql);
	                pst.setLong(1, id);
	                int apagado = pst.executeUpdate();
	                if (apagado>0){
	                    System.out.println("Concluido!");
	                } 
	            } catch (Exception e) {
	            	System.out.println(e);
	            }
				
			}catch(Exception e){
				System.out.println("Contato não encontrado!");
			}
		}else {
			System.out.println("Contato não encontrado!!!");
		}
	}
	
	public void Salva(Contatos c, Agenda minhaAgenda ) {
		try {
			minhaAgenda.addContato(c);
			//scan.nextLine();//conserta um problema de falha no scanner do metodo consultar	
			System.out.println("Contato adicionado com sucesso!");
		} catch (AgendaCheiaException e1) {
			System.out.println(e1.getMessage());
			System.out.println("Agenda atual:");
			System.out.println(minhaAgenda);
		}
	}
	
}
