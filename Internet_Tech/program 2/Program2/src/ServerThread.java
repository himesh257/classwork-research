import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.Socket;
import java.util.StringTokenizer;

class ServerThread extends Thread {
	private Socket socket; 
	BufferedReader in;

	public ServerThread(Socket s) {
		socket=s;
		start();
	}

    public void run() throws NullPointerException {
		String filename = null;
		try {

	      BufferedReader in=new BufferedReader(new InputStreamReader(socket.getInputStream()));
	      PrintStream out=new PrintStream(new BufferedOutputStream(socket.getOutputStream()));
	      String s=in.readLine();
	      filename="";
	      try {
	    	  StringTokenizer token=new StringTokenizer(s);
	    	  String method = token.nextToken().toUpperCase();
				if (method.equals("GET"))
					filename=token.nextToken();
				else
					throw new FileNotFoundException();
		
	        while (filename.indexOf("/")==0)
	          filename=filename.substring(1);

	        filename=filename.replace('/', File.separator.charAt(0));

	        InputStream f = new FileInputStream(filename);
			String content = contentType(filename); 
			out.print("HTTP/1.0 200 OK\r\n"+
			"Content-type: "+content+"\r\n\r\n");
			
	        byte[] a=new byte[1024];
	        int n;
	        while ((n=f.read(a))>0)
	          out.write(a, 0, n);
	        System.out.println("file " + filename + " sent");
	        System.out.println("file type: " + content);

	        out.close();
		} catch (NullPointerException n) {
			out.println("HTTP/1.0 404 Not Found\r\n"+
			"Content-type: text/html\r\n\r\n"+
			"<html><head></head><body>"+filename+" not found</body></html>\n");
			out.close();
			System.out.println("Error: " + n);
			System.out.println("This error occured because of null object has been passed to String Tokenizer");
		}
	      catch (FileNotFoundException x) {
	        out.println("HTTP/1.0 404 Not Found\r\n"+
	          "Content-type: text/html\r\n\r\n"+
	          "<html><head></head><body> file not found </body></html>\n");
	        out.close();
	        System.out.println("file " + filename + " not found");

	      }
	    }
	    catch (IOException x) {
	      System.out.println("Error: " + x);
	    }
	  }
		
	private static String contentType(String filename) {
		String mimeType="text/plain";
		if (filename.endsWith(".html") || filename.endsWith(".htm"))
			mimeType="text/html";
		else if (filename.endsWith(".jpg") || filename.endsWith(".jpeg"))
			mimeType="image/jpeg";
		else if (filename.endsWith(".bmp"))	
			mimeType="image/bmp";
		else if (filename.endsWith(".gif"))
			mimeType="image/gif";
		else
			mimeType="application/octet-stream";
		
		return mimeType;
	}
   
}
    	
    	
    	
    	
    	
    	
    	
    	
   