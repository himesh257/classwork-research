import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

public class ServerThread extends Thread {
	Socket sock;	              // Socket connected to the Client
	PrintWriter writeSock;     // Used to write data to socket
	PrintWriter logfile;
	BufferedReader readSock;

	public ServerThread(Socket s, PrintWriter logfile) {
		sock = s;
	    try {
			writeSock = new PrintWriter(sock.getOutputStream(), true);
			readSock = new BufferedReader( new InputStreamReader(
		            sock.getInputStream() ) );
		} catch (IOException e6) {
			logfile.write(e6.toString());
		}
	}

	public void start() {
		run();
	}	
	
	public void run() {
		boolean quitTime = true;
	    while( quitTime )
	    {
	       String inLine = null;
		   try {
				inLine = readSock.readLine();
		   } catch (IOException e4) {
			   logfile.write(e4.toString());
	       }
	       if( inLine.equals("quit")) {
	          quitTime = false;
	       	  logfile.write("Good Bye!");
	       }
	    }
	    try {
			sock.close();
			logfile.write("Connection closed. Port: 5520");
		} catch (IOException e5) {
			logfile.write(e5.toString());
		}
	}

}
