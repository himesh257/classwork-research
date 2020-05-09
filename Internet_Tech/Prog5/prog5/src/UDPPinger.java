/**
 * UDPPinger. Sends and receives PingPackets via Datagram socket. 
 */

import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.SocketTimeoutException;

public class UDPPinger 
{
    static final int MAX_PAYLOAD = 1024; 
    static final int REPLY_TIMEOUT = 1000;
    DatagramSocket socket;  
    /**
     * This method creates a Datagram socket.
     */
    public void createSocket()
    {
        try
        {
            socket = new DatagramSocket();
        }
        catch(Exception e)
        {
            System.out.println(e);
        }
    }
   
    /**
     * Given a PingPacket, this method makes an UDP packet using the payload, the
     * size, the destination address and the destination port, and sends the packet.
     */
    public void sendPing(PingPacket pm)
    {  
        DatagramPacket SendPing = new DatagramPacket(pm.getPayload().getBytes(),
                      pm.getPayload().length(),pm.getHost(), pm.getPort());
        try
        {
            socket.send(SendPing);
        }
        catch (Exception e)
        {
            System.out.println(e);
        }

    }
   
    /**
     * This method allocates a buffer with MAX_PACKET_LENGTH, receives the response
     * from the Server (socket), and displays the response on the system output.
     */
    public PingPacket receivePing() throws SocketTimeoutException   
    {
        PingPacket receivePingP = null; 
        byte[] buff = new byte[MAX_PAYLOAD];
        DatagramPacket ReceivePing = new DatagramPacket(buff, MAX_PAYLOAD);       
        try
        {
            socket.setSoTimeout(REPLY_TIMEOUT);
            socket.receive(ReceivePing);
            receivePingP = new PingPacket(ReceivePing.getAddress(),
                                          ReceivePing.getPort(),
                                          new String(ReceivePing.getData(), 
                                          0, ReceivePing.getLength()));
        }
        catch(SocketTimeoutException se)
        {
            System.out.println("receivePing...java.net.SocketTimeoutException: " 
                                + "Receive timed out");
        }
        catch (Exception e)
        {
            //System.out.println(e);
        }
        return receivePingP;
    }
}
