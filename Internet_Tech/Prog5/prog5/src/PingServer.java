/**
 * Ping Server. Handles incoming UDP packets. Echos back the packet. 
 */

import java.io.*;
import java.net.*;
import java.util.*;

public class PingServer
{
    private static final double LOSS_RATE = 0.3;
    private static final int DOUBLE = 2;
    private static final int AVERAGE_DELAY = 100; //milliseconds
    private static final int PACKET_LENGTH = 1024;
    
    public static void main(String[] args)
    {
        try
        {
            PingServer server = new PingServer();
            server.run();
        }
        catch (Exception e)
        {
            System.out.println(e);
        }
    }

    public void run()
    {
        DatagramSocket serverSocket = null;
        System.out.println("Ping Server running....");
        try
        {
            Random random = new Random(new Date().getTime());
            serverSocket = new DatagramSocket(5976);
            while (true)
            {
                try
                {
                    System.out.println("Waiting for UDP packet....");
                    byte[] buff = new byte[PACKET_LENGTH];
                    DatagramPacket packet = new DatagramPacket(buff, PACKET_LENGTH);
                    
                    //write codes for receiving the UDP packet
                    serverSocket.receive(packet);
                    
                    //write codes for displaying the packet content on the system output
                    String message = new String(packet.getData(), 
                                                0, packet.getLength());
                    System.out.println("Received from: " + 
                                       packet.getSocketAddress() + 
                                       " " + message);

                    if ( random.nextDouble() < LOSS_RATE ) //simulate packet loss
                    {
                        System.out.println("Packet loss...., reply not sent.");
                        continue;
                    }
                    //simulate network delay
                    Thread.sleep((int)(random.nextDouble() * DOUBLE * AVERAGE_DELAY));
                    
                    //sends the packet
                    serverSocket.send(packet);
                    
                    //write codes for displaying the packet sent message 
                    //on the system output
                    System.out.println("Reply Sent.");
                }
                catch (IOException e)
                {
                    System.out.println("Datagram packet error...." + e);
                }
                catch (InterruptedException e)
                {
                    continue;
                }
            } //end while
        }
        catch (SocketException e)
        {
            System.out.print("DatagramSocket error..." + e);
        }
        serverSocket.close();
    } //end run()
}
