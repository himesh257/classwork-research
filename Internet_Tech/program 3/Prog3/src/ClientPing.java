import java.io.*;
import java.net.*;
import java.util.*;

public class ClientPing
{
	private static final double LOSS_RATE = 0.3;
	private static final int AVERAGE_DELAY = 100; // milliseconds
	static DatagramPacket request1;
	static DatagramPacket response1;
	static DatagramSocket socket1;
	static boolean received = false;
	public static int num = 0;
	/*
	PingClient()
	{
	Thread thisThread = new Thread( this );
	thisThread.start();
	}
	*/
	public static void main(String[] args) throws Exception {
// Get command line argument.
	/*if (args.length < 2) {
	System.out.println("Required arguments: port, address");
	return;
	}*/
	int port = 5520;
	
	// Create random number generator for use in simulating
	// packet loss and network delay.
	Random random = new Random();
	
	// Create a datagram socket for receiving and sending UDP packets
	// through the port specified on the command line.
	DatagramSocket socket = new DatagramSocket(port);
	  
	/* DatagramConnection sender =
	(DatagramConnection)Connector.open("datagram://target:32767"); */
	
	// Processing loop.
	received = false;
	while (!received)
	{
	byte kilo[] = new byte[1024];
	char[] transfer;
	String num2 = "" + num;
	transfer = num2.toCharArray();
	for(int i = 0; i < transfer.length; i++)
	{
	kilo[i] = (byte)transfer[i];
	}
	// Create a datagram packet to hold outgoing UDP packet.
	InetAddress address = InetAddress.getByName("constance.cs.rutgers.edu");
	request1 = new DatagramPacket(kilo, kilo.length, address /* InetAddress ipAddress */ , /* int port */ 1024); // port 1024
	// InetAddress.getLocalHost()
	DatagramPacket response2 = new DatagramPacket(kilo, kilo.length);
	
	try {
		socket1.send(request1);
	} catch(NullPointerException e) {
		System.out.println(e);
	}
	System.out.println("Starting thread");
	//PingThread ping = new PingThread(request1, response1, socket1, received, num);
	ThreadPing ping = new ThreadPing();
	ping.PingThread(request1, response1, socket1, received, num);
	// ping.start();
	
	// System.out.println("hello");
	try {
		socket1.receive(response1); // REVEIEVE NOTHING BACK
	} catch(NullPointerException e) {
		System.out.println(e);
	}
	// Thread.sleep(200);
	ping.myStop();
	System.out.println("hello");
	
	
	// System.out.println("Hello; 3");
	/*
	InetAddress serverHost = request1.getAddress();
	int serverPort = request1.getPort();
	byte[] buf = request1.getData();
	DatagramPacket reply = new DatagramPacket(buf, buf.length, serverHost, serverPort);
	socket1.send(reply);
	*/
	// end insertion
	
	printData(response1);
	  
	received = true;
	/*
	// Decide whether to reply ELSE simulate packet loss.
	if (random.nextDouble() < LOSS_RATE) {
	System.out.println("Reply not sent.");
	continue;
	}
	
	// Simulate network delay.
	Thread.sleep((int) (random.nextDouble() * 2 * AVERAGE_DELAY));
	
	// reply SEND.
	InetAddress clientHost = request1.getAddress();
	int clientPort = request1.getPort();
	byte[] buf = request.getData();
	DatagramPacket reply = new DatagramPacket(buf, buf.length, clientHost, clientPort); // a length here
	socket.receive(reply);
	
	System.out.println(" recieved reply.");
	*/
	//received = false;
	//num++;
	//if(num == 11)
	//return;
	//System.out.println(num);
	}
	}
	
	
	
	/*
	public void run()
	{
	System.out.println("Hello");
	try
	{
	Thread.sleep(200);
	}
	catch(InterruptedException e)
	{
	System.out.println("Bug detected: " + e);
	}
	if(!received)
	{
	try
	{
	socket1.send(request1);
	Thread thisThread = new Thread( this );
	thisThread.start();
	socket1.receive(response1);
	}
	catch(IOException e)
	{
	System.out.println("the Bug detected: " + e);
	}
	}
	}
	*/
	
	
	
	
	/*
	* Print ping data to the standard output stream.
	*/
	public static void printData(DatagramPacket request) throws Exception
	{
	// Obtain references to the packet's array of bytes.
	byte[] buf = request1.getData();
	
	// Wrap/cover the bytes in a byte array input stream,
	// since, you could read the data as a stream of bytes.
	ByteArrayInputStream bais = new ByteArrayInputStream(buf);
	
	// Wrap/cover the byte array output stream in an input stream reader,
	// since you could read the data as a stream of characters.
	InputStreamReader isr = new InputStreamReader(bais);
	
	// Wrap/cover the input stream reader in a bufferred reader,
	// since you can read the character data a line at a time.
	//
	BufferedReader br = new BufferedReader(isr);
	
	// The msg data is contain in the single line, so you can read this line.
	String line = br.readLine();
	
	// Print host address along with data received from it.
	System.out.println(
	"Received from " +
	request1.getAddress().getHostAddress() +
	": " +
	new String(line) );
	}
}
