import java.io.*;
import java.net.*;

public class Server {

	static String hostname = "127.0.0.1";
	private static ServerSocket serverSocket;
	static int port = 5520;
	static String filename;
	static long fileSize;
	static String source;
	static String destination;
    static int computedBytes;
    
	public static void main(String[] args) throws IOException {
		System.out.println("Server running ...");
		serverSocket=new ServerSocket(port); 

		while (true) {
			try {
				System.out.println("Waiting for connection ...");
				Socket s = serverSocket.accept(); 
				java.util.Date date = new java.util.Date();
			    System.out.println("Got a connection: " + date);
				System.out.println("Connected to: /"+ hostname  +" Port: " + port);

				// Using the dataStream coming from the client 
				InputStream inputStream = s.getInputStream();
		        DataInputStream data = new DataInputStream(inputStream); 
		        
		        // Getting the filename
		        String fileName = data.readUTF();
		        
		        // Setting the output fileName as an object, and the name is
		        // set as the original filename
		        OutputStream output = new FileOutputStream(fileName);  
		        
		        // Getting the size, again, it is coming from the client
		        long size = data.readLong();   
		        System.out.println("Got a file: " + fileName);
				System.out.println("File Size: " + size);
				
				// Creating the byte array of chunks of size 1024
		        byte[] buffer = new byte[1024];   
		        
		        // The loop to write the file
		        while (size > 0 && (computedBytes = data.read(buffer, 0, (int)Math.min(buffer.length, size))) != -1)   
		        {   
		            output.write(buffer, 0, computedBytes);   
		            size -= computedBytes;   
		        }
		         
		        // Closing the FileOutputStream handle
		        output.close();
			}
			catch (Exception x) {
				System.out.println("Error: " + x.toString());
				System.out.println("Connection closed");
			}
		}
	}
}

