
import java.sql.*;

public class ModuloConexao {
	    // metodo responsavel por estabelecer a conexao com o banco
	    
	    public static Connection conector(){
	        java.sql.Connection conexao = null;
	        // a linha abaixo "chama" o driver de conexao
	        String driver = "com.mysql.cj.jdbc.Driver";
	        // armazenando informacoes referentes ao banco
	        String url = "jdbc:mysql://localhost:3306/agenda?useTimezone=true&serverTimezone=UTC";
	        String user = "root";
	        String password = "";
	        // estabelecendo a conexao com o banco
	        try {
	            Class.forName(driver);
	            conexao = DriverManager.getConnection(url,user,password);
	            return conexao;
	        } catch (Exception e) {
	            System.out.println(e);
	            return null;
	        }
	   }
}
