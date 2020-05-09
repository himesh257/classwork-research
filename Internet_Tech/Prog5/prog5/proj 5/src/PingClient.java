import java.io.*;
import java.net.*;
import java.util.*;

public class PingClient
{
    private static final double LOSS_RATE = 0.3;
    private static final int DOUBLE = 2;
    private static final int AVERAGE_DELAY = 100;
    private static final int PACKET_LENGTH = 512;
    static final int port = 5520;
    static final String host = "constance.cs.rutgers.edu";
    
    public static void main(String[] args)
    {
        try {
            PingClient server = new PingClient();
            server.run();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    
    @SuppressWarnings("null")
	public void run()
    {
        DatagramSocket udpSocket = null;
        System.out.println("Ping Server running....");
        try {
        	
        	//generate a random number between 0 and 1; it’s a inpacket loss if the random number is
        	//less than LOSS_RATE
            Random random = new Random(new Date().getTime());
            udpSocket = new DatagramSocket();
            while (true) {
                try {
                    System.out.println("Waiting for UDP inpacket....");
                    
                    //allocate the memory space for an UDP packet 
                    byte[] buff = new byte[PACKET_LENGTH];
                    
                    //create the socket for receiving UDP packets 
                    DatagramPacket inpacket = new DatagramPacket(buff, PACKET_LENGTH);
                    
                    // receiving UDP packets
                    udpSocket.receive(inpacket);
                    String message = new String(inpacket.getData(), 0, inpacket.getLength());
                    System.out.println("Received from: " + inpacket.getSocketAddress() + " " + message);

                    // checking if packet loss happened
                    if ( random.nextDouble() < LOSS_RATE ) {
                        System.out.println("Packet loss...., reply not sent.");
                        continue;
                    }

                    // checking for transmission delay
                    Thread.sleep((int)(random.nextDouble() * DOUBLE * AVERAGE_DELAY)); 
                    
                    // sending UDP packet
                     udpSocket.send(inpacket);
                    System.out.println("Reply Sent.");
                } catch (IOException e) {
                    System.out.println("Datagram inpacket error...." + e);
                } catch (InterruptedException e) {
                    continue;
                }
            }
        }
        catch (SocketException e) {
            System.out.print("DatagramSocket error..." + e);
        }
        udpSocket.close();
    }
}
