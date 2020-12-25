import java.awt.*;
import java.util.*;


public class FxBall extends Ball {

    //Guardara as os estados que formarao a cauda da bola
    private Queue<BallState> rabicho = new LinkedList<>();

	public FxBall(double cx, double cy, double width, double height, Color color, double speed, double vx, double vy){

		super(cx, cy, width, height, color, speed, vx, vy);
	}

	public void draw(){

        double factor = getWidth() * 0.0125; //Define o fator que sera subtraido da bola 
        double count = getWidth() - factor;
        int size = 80;

        GameLib.setColor(getColor().darker());

        //Desenha toda a fila rabicho
        for (Iterator<BallState> it = rabicho.iterator(); it.hasNext();) {
            BallState s = it.next();
            GameLib.fillRect(s.getCx(), s.getCy(), getWidth()-count, getHeight()-count);
            count -= factor;
        };
        
        //Desenha a bola 
        GameLib.setColor(getColor());
        GameLib.fillRect(getCx(), getCy(), getWidth(), getHeight());

        //Define o tamanho do rabicho
        if(rabicho.size() >= size){
            rabicho.remove();
        }

        //adiciona um nov0 estado ao rabicho
        BallState actual = new BallState(getCx(), getCy());
        rabicho.add(actual);
        
	}
}

//Contem as coordenadas da bola em um momento especifico
class BallState{
    private double cx;
    private double cy;
    
    BallState(double x, double y){
        this.cx = x;
        this.cy = y;
    }

    public double getCx(){
		return this.cx;
	}

	public double getCy(){
		return this.cy;
    }

}