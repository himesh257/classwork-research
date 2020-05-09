import java.io.*;
import java.net.*;
import java.util.*;


/**
* Write a description of class ThreadPing here.

*/
public class ThreadPing implements Runnable
{
	static DatagramPacket request1;
	static DatagramPacket response1;
	static DatagramSocket socket1;
	static boolean received = false;
	static int num1;
	public static boolean stopFlag = false;
	
	public void myStop()
	{
		received = true;
		stopFlag = true;
	}
	
	void PingThread(DatagramPacket request1, DatagramPacket response1, DatagramSocket socket1, boolean received, int num1)
	{
		stopFlag = false;
		this.request1 = request1;
		this.response1 = response1;
		this.socket1 = socket1;
		this.received = received;
		this.num1 = num1;
		Thread thisThread = new Thread( this );
		thisThread.start();
	}
	public void run()
	{
		// ClientPing check = new ClientPing();
		// System.out.println("Hello");
		while(!received)
		{
			try
			{
				Thread.sleep(200); // problem is that this will wait for too long
				if(stopFlag)
				{
					System.out.println("returning");
					break;
				}
				System.out.println("num1: " + num1);
			}
			catch(InterruptedException e)
			{
				System.out.println("the Bug detected: " + e);
			}
		//if(!received)
		//{
			try
			{
				socket1.send(request1);
				// Thread thisThread = new Thread( this ); // this could be the problem
				// thisThread.start();
				// socket1.receive(response1);
				num1++;
			}
			catch(IOException e)
			{
				System.out.println("THE Bug detected: " + e);
			}
	//}
		}
	}
}