/**
 * UDP Client. Sends and receives UDP packet. Calculates and displays
 * Round Trip Times. Calculates average, min, and max. 
 */

import java.net.InetAddress;
import java.util.Date;

public class UDPClient extends UDPPinger implements Runnable
{
    static final int NUM_PINGS = 10;
    static final int TIMEOUT = 1000; //1 second
    static final int REPLY_TIMEOUT = 5000; //5 seconds
    static final int PORT_CONST = 5976;
    static final String HOST_CONST = "localhost";
    private String host;
    private int port;

    static boolean[] replies = new boolean[NUM_PINGS]; //keep track of the replies
    static long[] rtt = new long[NUM_PINGS]; //keep track of the RTTs

    
    public UDPClient(String inHost, int inPort) //constructor
    {
        host = inHost;
        port = inPort;
    }
    
    public static void main(String arg[])
    {
        UDPClient client = new UDPClient(HOST_CONST, PORT_CONST);
        client.run();
    }
    
    /**
    * Given the payload of a UDP packet, this helper method calculates the RTT,
    * and uses the ping number as the index to store the RTT in the array.
    * RTT = (current timestamp) – (previous timestamp when sending the packet)
    * A counter is used to keep track of the number of valid replies from the
    * Server.
    */
    private void handleRTT(String payload)
    {
        String[] parts = payload.split(" ");
        long time;
        time = new Date().getTime() - Long.valueOf(parts[2]);
        rtt[Integer.valueOf(parts[1])] = time;  
    }
    
    @Override
    public void run()
    {
        System.out.println(" Contecting host: " + host + " at port " + port);
        createSocket();
        for(int i = 0; i < NUM_PINGS; i++)
        {
            try
            { 
                PingPacket pingPacket = new PingPacket(InetAddress.getByName(host), port, 
                          "PING " + i + " " + String.valueOf(new Date().getTime()));
                sendPing(pingPacket);   
                PingPacket receivePingPacket = receivePing();
                System.out.println("Received packet from " + 
                        receivePingPacket.getHost().toString() + " " + 
                        receivePingPacket.getPort() + " " + new Date().toString());
                replies[i] = true;
                handleRTT(receivePingPacket.getPayload());
            }
            catch(Exception e)
            {
                //System.out.println(e);
            }
        }
        
        //Sets all timeout ping to 1000ms
        //Prints out each ping
        for(int i = 0; i < NUM_PINGS; i++)
        {
            if(replies[i] == false)
            {
                rtt[i] = TIMEOUT;
            }
            System.out.println("PING " + i + ": " + replies[i] 
                                       + " RTT: " + rtt[i]);
        }   
        
        //Computes the average, min, and max 
        long ave, min, max;  
        ave = rtt[0];
        min = max = ave;
        if(replies[0] == false)
        {
            rtt[0] = TIMEOUT;
        }
        for(int i = 1; i < NUM_PINGS; i++)
        {
            if(replies[i] == false)
            {
                rtt[i] = TIMEOUT;
            }  
            ave += rtt[i];
            if(min > rtt[i])
                min = rtt[i];
            if(max < rtt[i])
                max = rtt[i];
        }
        ave = ave / NUM_PINGS;
        System.out.println("Minimum = " + min + " Maximum = " + max 
                                            + " Average = " + ave );
        }
  
        //create the socket and set time out to 1 second.
        //set up a for loop to send 10 ping messages, and record 
        //replies and RTTs.
        //if less than 10 replies, set time out to 5 seconds, just in 
        //case replies are on the way.
        //compute and print the average RTT, minimum and maximum RTTs.
}
    

