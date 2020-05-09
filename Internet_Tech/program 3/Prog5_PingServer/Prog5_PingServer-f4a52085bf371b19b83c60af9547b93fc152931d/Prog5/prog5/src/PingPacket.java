/**
 * Ping Packet. Holds information about a packet. 
 */

import java.net.InetAddress;

public class PingPacket 
{
    private InetAddress hostAddr;
    private int port;
    private String payload;
    
    /**
    * This is the constructor.
    */
    public PingPacket(InetAddress hostaddr, int port, String payload)
    {
        hostAddr = hostaddr;
        this.port = port;
        this.payload = payload;
    }
    
    /**
    * This method returns the host IP address
    */
    public InetAddress getHost()
    {
        return hostAddr;  
    }
    
    /**
    * This method returns the port number
    */
    public int getPort()
    {
        return port;   
    }
    
    /**
    * This method returns the payload
    */
    public String getPayload() 
    {
        return payload;  
    }   
}
