import java.io.*;
import java.net.*;

public class server1 {

	private static ServerSocket serverSocket;
	static int port = 5520;
	public static void main(String[] args) throws IOException {
		System.out.println("Server started on port 5520..");

		serverSocket=new ServerSocket(port); 
		while (true) {
			try {
				Socket s=serverSocket.accept();  
				new ServerThread(s); 
			}
			catch (Exception x) {
				System.out.println(x);
				System.out.println("Connection closed");
			}
		}
	}
}

