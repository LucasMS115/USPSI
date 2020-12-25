import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.stream.Stream;


public class ListArq{

	public static void main(String[] args){

		Path root = Paths.get(System.getProperty("user.home"));
		try{
			Stream<?> s = Files.walk(root);
			s.forEach(c -> {
				Path p = Paths.get(c.toString());
				if(!Files.isDirectory(p)) System.out.println(p.getFileName());
			});
			s.close();
		}catch(Exception e){}

	}

}
