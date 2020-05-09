import java.net.InetAddress;

public class PingMessage 
{
    private InetAddress hostname;
    private int port;
    private String payload;
    
    public PingMessage(InetAddress hostname, int port, String payload) {
        this.hostname = hostname;
        this.port = port;
        this.payload = payload;
    }
    
    public InetAddress getHost() {
        return hostname;  
    }
    
    public int getPort() {
        return port;   
    }
    
    public String getPayload() {
        return payload;  
    }   
   
}
