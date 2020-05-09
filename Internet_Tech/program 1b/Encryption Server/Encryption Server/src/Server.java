import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;

public class Server {
	String hostname = "localhost";
	int port = 5520;
	
	/*public Server(String hostname, int port) {
		this.hostname = hostname;
		port = port;
	}*/

	public void run() {
		System.out.println(hostname);
		System.out.println(port);
		
		//int portNum = 5520;
	    ServerSocket servSock = null;
		try {
			servSock = new ServerSocket( port );
		} catch (IOException e2) {
			System.out.println(e2.toString());
		}
	    while( true )
	    {
	        Socket sock = null;
			try {
				sock = servSock.accept();
				InputStreamReader isr = new InputStreamReader(clientSocket.getInputStream()); 
				BufferedReader reader = new BufferedReader(isr); 
				String line = reader.readLine(); 
				while (!line.isEmpty()) { 
					System.out.println(line); 
					line = reader.readLine(); 
					}
				}
				System.out.println("Got a connection: "+ hostname +" Port: " + port)
			} catch (IOException e3) {
				System.out.println(e3.toString());
			}  
			ServerThread servThread = new ServerThread( sock );
			servThread.start();
	    }
	}
	
	public static void main(String[] args) {
	    Server server = new Server();
	    server.run();
	}
}














