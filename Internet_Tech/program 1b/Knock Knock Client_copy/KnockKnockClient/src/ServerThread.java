import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.net.SocketException;

class ServerThread extends Thread {
	Socket sock;	              // Socket connected to the Client
	PrintWriter writeSock;        // Used to write data to socket
	BufferedReader readSock;

	// Constructor
	public ServerThread(Socket s) {
	    try {
	    	this.sock = s;
			writeSock = new PrintWriter(sock.getOutputStream(), true);
			readSock = new BufferedReader( new InputStreamReader(
		            sock.getInputStream() ) );
		} catch (IOException e6) {
			e6.printStackTrace();
		}
	}
	
	// run() method that is called by start() from Server class
	public void run() {
		boolean quitTime = true;
	    while( quitTime )
	    {
		   try {
			   String inLine = readSock.readLine();
				//CeaserCipher encrypt = new CeaserCipher();
				
				if( inLine.equals("quit")) {
					quitTime = false;
			        writeSock.println("Good Bye!\n");
				    this.sock.close();
				} else {
					// returning the encrypted string from CeaserCipher class
					// String outLine = encrypt.encrypt(inLine) ;
				    writeSock.println( inLine );
			    } 
		   } catch (IOException e4) {
			   //e4.printStackTrace();
	       } 
	    }	
	    try {
			this.sock.close();
			System.out.println("Connection closed. Port: 5520");
		} catch (IOException e) {
			e.printStackTrace();
		}
	    
	}

}
