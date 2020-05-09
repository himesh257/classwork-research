import java.math.BigInteger;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketTimeoutException;
import java.util.Date;

public class UDPPinger
{
    static final int NUMBER_OF_PINGS = 10;
    static final int PACKET_SIZE = 512;
    static final int TIMEOUT = 1000;
    static final int REPLY_TIMEOUT = 5000;
    static final int PORT = 5530;
    static final String HOST = "constance.cs.rutgers.edu";
    static boolean[] replies = new boolean[NUMBER_OF_PINGS];
    static long[] rtt = new long[NUMBER_OF_PINGS];
    private String host;
    private int port;
    DatagramSocket socket;  
    
    public UDPPinger(String hostname, int portNum)
    {
        host = hostname;
        port = portNum;
    }
    
    
    public static void main(String arg[])
    {
        UDPPinger client = new UDPPinger(HOST, PORT);
        client.run();
    }
    
    // We use this formula to compute RTT
    // RTT = (current timestamp) – (previous timestamp when sending the packet)
    private void Timestamp(String payload)
    {
    	//System.out.println(payload);
        String[] timeString = payload.split(" ");
        long time2 = new Date().getTime();
        //System.out.println(timeString[2]);
        //System.out.println(time2);
        long time = Math.subtractExact(time2,Long.parseLong(timeString[2]));

        rtt[Integer.valueOf(timeString[1])] = time;  
        //System.out.println("rtt");
        //System.out.println(rtt);
    }
    
   
    // passing hostname and port here along with other info
    // that
    public void sendPing(PingMessage packet) {  
        DatagramPacket ping = new DatagramPacket(packet.getPayload().getBytes(),
                      packet.getPayload().length(),packet.getHost(), packet.getPort());
        try {
            socket.send(ping);
        } catch (Exception e) {
            System.out.println(e);
        }
    }
   
    public PingMessage receivePing() {
        PingMessage receivePingP = null; 
        byte[] buffer = new byte[PACKET_SIZE];
        DatagramPacket ReceivedPing = new DatagramPacket(buffer, PACKET_SIZE);       
        try {
            socket.setSoTimeout(TIMEOUT);
            socket.receive(ReceivedPing);
            receivePingP = new PingMessage(ReceivedPing.getAddress(),ReceivedPing.getPort(), new String(ReceivedPing.getData(), 
                                          0, ReceivedPing.getLength()));
        } catch(SocketTimeoutException se) {
            System.out.println("receivePing...java.net.SocketTimeoutException: " + "Receive timed out");
        } catch (Exception e) {
            System.out.println(e);
        }
        return receivePingP;
    }
    
    public void run() {
        System.out.println("Contecting host: " + host + " at port " + port);
        
        // Creating socket datagram
        try {
            socket = new DatagramSocket();
        } catch(Exception e) {
            System.out.println(e);
        }
        
        for(int i = 0; i < NUMBER_OF_PINGS; i++) {
            try { 
                PingMessage pinger = new PingMessage(InetAddress.getByName(host), port, "PING " + i + " " + new Date().getTime());
                sendPing(pinger);   
                PingMessage received = receivePing();
                System.out.println("Received packet from " + received.getHost().toString() + " " + 
                        received.getPort() + " " + new Date().toString());
                replies[i] = true;
                Timestamp(received.getPayload());
            } catch(Exception e) {
                //System.out.println(e);
            }
        }
        
        // sending 10 pings via this loop
        for(int i = 0; i < NUMBER_OF_PINGS; i++) {
            if(replies[i] == false) {
                rtt[i] = TIMEOUT;
            }
            System.out.println("PING " + i + ": " + replies[i] + " RTT: " + rtt[i]);
        }   
        
        // Computing and outputting the average RTT, minimum and maximum RTTs.
        // The RTT is set to 1000 milliseconds in case of a packet loss.
        long ave;
        long min;
        long max;  
        ave = rtt[0];
        min = max = ave;
        if(replies[0] == false) {
            rtt[0] = TIMEOUT;
        }
        for(int i = 1; i < NUMBER_OF_PINGS; i++) {
            if(replies[i] == false) {
                rtt[i] = TIMEOUT;
            }  
            ave += rtt[i];
            if(min > rtt[i])
                min = rtt[i];
            if(max < rtt[i])
                max = rtt[i];
        }
        ave = ave / NUMBER_OF_PINGS;
        System.out.println("Minimum = " + min + "ms Maximum = " + max + "ms Average = " + ave + "ms");
    }
 
}
    

