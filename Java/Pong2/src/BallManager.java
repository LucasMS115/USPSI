import java.awt.Color;
import java.lang.reflect.*;
import java.util.*;


//Elemento que representará as bolas temporarias
class Element{
	Element(IBall b){
		this.b = b;
	}

	private IBall b; // b de bola, q vai ser duplicada
	private long timeLeft = DuplicatorTarget.EXTRA_BALL_DURATION; //Tempo restante da bola temporaria
	private double leftSpd = 0; // tempo restante do boost de velocidade da bola temporaria

	public IBall getBall(){
		return this.b;
	}

	public long getTimeDup(){
		return this.timeLeft;
	}

	public double getTimeSpd(){
		return this.leftSpd;
	}

	public void setTimeDup(long t){
		this.timeLeft = t;
	}

	public void setTimeSpd(double t){
		this.leftSpd = t;
	}


}

/**
	Classe que gerencia uma ou mais bolas presentes em uma partida. Esta classe é a responsável por instanciar 
	e gerenciar a bola principal do jogo (aquela que existe desde o ínicio de uma partida), assim como eventuais 
	bolas extras que apareçam no decorrer da partida. Esta classe também deve gerenciar a interação da(s) bola(s)
	com os alvos, bem como a aplicação dos efeitos produzidos para cada tipo de alvo atingido.
*/

public class BallManager {

	/**
		Atributo privado que representa a bola principal do jogo.	
	*/

	private IBall theBall = null;

	private double spd; //Velocidade padrão das bolas

	private double leftSpd = 0; //Tempo do boost de velocidade da bola principal 
	
	private Set<Element> dupBalls = new HashSet<>(); //Guardará todas as bolas temporarias ativas

	private double dupTime = DuplicatorTarget.EXTRA_BALL_DURATION;

	/**
		Atributo privado que representa o tipo (classe) das instâncias de bola que serão criadas por esta classe.
	*/

	private Class<?> ballClass = null;

	/**
		Construtor da classe BallManager.
		
		@param className nome da classe que define o tipo das instâncias de bola que serão criadas por esta classe. 
	*/


	public BallManager(String className){

		try{
			ballClass = Class.forName(className);
		}
		catch(Exception e){

			System.out.println("Classe '" + className + "' não reconhecida... Usando 'Ball' como classe padrão.");
			ballClass = Ball.class;
		}
	}

	/**
		Recebe as componetes x e y de um vetor, e devolve as componentes x e y do vetor normalizado (isto é, com comprimento igual a 1.0).
	
		@param x componente x de um vetor que representa uma direção.
		@param y componente y de um vetor que represetna uma direção.

		@return array contendo dois valores double que representam as componentes x (índice 0) e y (índice 1) do vetor normalizado (unitário).
	*/
	private double [] normalize(double x, double y){

		double length = Math.sqrt(x * x + y * y);

		return new double [] { x / length, y / length };
	}
	
	/**
		Cria uma instancia de bola, a partir do tipo (classe) cujo nome foi passado ao construtor desta classe.
		O vetor direção definido por (vx, vy) não precisa estar normalizado. A implemntação do método se encarrega
		de fazer a normalização.

		@param cx coordenada x da posição inicial da bola (centro do retangulo que a representa).
		@param cy coordenada y da posição inicial da bola (centro do retangulo que a representa).
		@param width largura do retangulo que representa a bola.
		@param height altura do retangulo que representa a bola.
		@param color cor da bola.
		@param speed velocidade da bola (em pixels por millisegundo).
		@param vx componente x do vetor (não precisa ser unitário) que representa a direção da bola.
		@param vy componente y do vetor (não precisa ser unitário) que representa a direção da bola.
	*/

	private IBall createBallInstance(double cx, double cy, double width, double height, Color color, double speed, double vx, double vy){

		IBall ball = null;
		double [] v = normalize(vx, vy);

		try{
			Constructor<?> constructor = ballClass.getConstructors()[0];
			ball = (IBall) constructor.newInstance(cx, cy, width, height, color, speed, v[0], v[1]);
		}
		catch(Exception e){

			System.out.println("Falha na instanciação da bola do tipo '" + ballClass.getName() + "' ... Instanciando bola do tipo 'Ball'");
			ball = new Ball(cx, cy, width, height, color, speed, v[0], v[1]);
		}

		return ball;
	} 

	/**
		Cria a bola principal do jogo. Este método é chamado pela classe Pong, que contem uma instância de BallManager.

		@param cx coordenada x da posição inicial da bola (centro do retangulo que a representa).
		@param cy coordenada y da posição inicial da bola (centro do retangulo que a representa).
		@param width largura do retangulo que representa a bola.
		@param height altura do retangulo que representa a bola.
		@param color cor da bola.
		@param speed velocidade da bola (em pixels por millisegundo).
		@param vx componente x do vetor (não precisa ser unitário) que representa a direção da bola.
		@param vy componente y do vetor (não precisa ser unitário) que representa a direção da bola.
	*/

	public void initMainBall(double cx, double cy, double width, double height, Color color, double speed, double vx, double vy){

		theBall = createBallInstance(cx, cy, width, height, color, speed, vx, vy);
		this.spd = theBall.getSpeed(); //Guardar a velocidade inicial da bola principal como velocidade padrão para todas as bolas
	}

	/**
		Método que desenha todas as bolas gerenciadas pela instância de BallManager.
		Chamado sempre que a(s) bola(s) precisa ser (re)desenhada(s).
	*/

	public void draw(){

		theBall.draw();

		Iterator<Element> it = dupBalls.iterator();

		while (it.hasNext()) { //Desenhar bolas temporarias
			Element e = it.next();
			e.getBall().draw(); 
		};
		
	}
	
	/**
		Método que atualiza todas as bolas gerenciadas pela instância de BallManager, em decorrência da passagem do tempo.
		
		@param delta quantidade de millisegundos que se passou entre o ciclo anterior de atualização do jogo e o atual.
	*/

	public void update(long delta){
	
		theBall.update(delta);

		//Gerenciamento da velocidade da bola principal
		if(this.leftSpd >= 0) this.leftSpd -= delta;
		else this.theBall.setSpeed(this.spd);


		if(dupBalls.size() > 0){

			//Converte o Hashset em array para q seja possivel a modificacao durante a iteracao
			Element[] arr = dupBalls.toArray(new Element[dupBalls.size()]); 

			//Atualiza a situação de todas as bolas temporarias ativas
			for(int i = 0; i <= arr.length -1; i++){

				arr[i].getBall().update(delta);

				if(arr[i].getTimeDup() <= 0) dupBalls.remove(arr[i]);
				else arr[i].setTimeDup(arr[i].getTimeDup() - delta);

				fadeDup(arr[i].getTimeDup(), arr[i].getBall()); 

				if(arr[i].getTimeSpd() >= 0)	arr[i].setTimeSpd(arr[i].getTimeSpd() - delta);
				else arr[i].getBall().setSpeed(spd);	
			}
		}

	}

	//Efeito de fade da bola com tempo acabando
	private void fadeDup(long t, IBall b){

		if(t < this.dupTime/6 && t > 0){	
			int red = Math.round(t/2);
				if(red >= 50){
					Color darkRed = new Color(red,0,0);
				b.setColor(darkRed);
			};
		}	
		
	}

	private void insertEl(IBall b){

		//Numero aleatorio q servira de perturbacao do vetor da bola a ser duplicada
		double mod = Math.random();

		IBall dup =  createBallInstance(b.getCx(), b.getCy(), b.getWidth(), b.getHeight(), b.getColor(), b.getSpeed(), b.getVx()+mod, b.getVy()+mod);

		dup.setColor(Color.RED);
		dup.setSpeed(this.spd);

		Element el = new Element(dup); //Cria o elemento com a duplicata

		dupBalls.add(el); //Insere o elemento no set
	}
	
	/**
		Método que processa as colisões entre as bolas gerenciadas pela instância de BallManager com uma parede.

		@param wall referência para uma instância de Wall para a qual será verificada a ocorrência de colisões.
		@return um valor int que indica quantas bolas colidiram com a parede (uma vez que é possível que mais de 
		uma bola tenha entrado em contato com a parede ao mesmo tempo).
	*/

	public int checkCollision(Wall wall){

		int hits = 0;

		if(theBall.checkCollision(wall)) hits++;

		//Colisao com a parede das bolas temporarias
		Iterator<Element> it = dupBalls.iterator();
		while (it.hasNext()) {
			Element e = it.next();
			e.getBall().checkCollision(wall);
		}

		return hits;
	}

	/**
		Método que processa as colisões entre as bolas gerenciadas pela instância de BallManager com um player.

		@param player referência para uma instância de Player para a qual será verificada a ocorrência de colisões.
	*/
	
	public void checkCollision(Player player){

		theBall.checkCollision(player);

		//Colisao com os players das bolas temporarias
		Iterator<Element> it = dupBalls.iterator();
		while (it.hasNext()) {
			Element e = it.next();
			e.getBall().checkCollision(player);
		}
	}

	/**
		Método que processa as colisões entre as bolas gerenciadas pela instância de BallManager com um alvo.

		@param target referência para uma instância de Target para a qual será verificada a ocorrência de colisões.
	*/

	public void checkCollision(Target target){

		//Tratamento da bola principal
		if(theBall.checkCollision(target)){

			if(target instanceof DuplicatorTarget){
				insertEl(theBall);
			}else if (target instanceof BoostTarget){
				if(this.leftSpd <= 0){
					 this.leftSpd = BoostTarget.BOOST_DURATION;
					 this.theBall.setSpeed(this.theBall.getSpeed() * BoostTarget.BOOST_FACTOR);
				};	 
			};
		};
			

		//Tratamento das bolas temporarias
		if(dupBalls.size() > 0){
			Element[] arr = dupBalls.toArray(new Element[dupBalls.size()]);
			for(int i = 0; i <= arr.length -1; i++){
				
				if(arr[i].getBall().checkCollision(target)){

					if(target instanceof DuplicatorTarget) insertEl(arr[i].getBall()); //Cria bola temporaris na colisao com o Duplicator Target 
					else if (target instanceof BoostTarget){
						if(arr[i].getTimeSpd() <= 0){
							arr[i].setTimeSpd(BoostTarget.BOOST_DURATION);
							arr[i].getBall().setSpeed(arr[i].getBall().getSpeed() * BoostTarget.BOOST_FACTOR); //Add o boos de vel a bola temporaria
						}
					}
					
					
				};

			}
		}
		

	}
}


