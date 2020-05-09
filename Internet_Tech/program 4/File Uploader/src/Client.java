import java.awt.EventQueue;
import java.net.Socket;
import java.net.UnknownHostException;
import java.io.File;
import java.io.FileInputStream;
import javax.swing.JFrame;
import javax.swing.JTextArea;
import javax.swing.JLabel;
import javax.swing.JTextField;
import javax.swing.filechooser.FileNameExtensionFilter;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedInputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import javax.swing.JScrollPane;

public class Client {

	private JFrame frmFileUploader;
	private JTextField txthost;
	private static Socket sock; 

	/**
	 * Launch the application.
	 * @throws UnknownHostException 
	 */
	public static void main(String[] args) throws UnknownHostException, IOException {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					Client window = new Client();
					window.frmFileUploader.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the application.
	 */
	public Client() {
		initialize();
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {
		frmFileUploader = new JFrame();
		frmFileUploader.setTitle("Program 4 - a File Uploader");
		frmFileUploader.setBounds(100, 100, 646, 748);
		frmFileUploader.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frmFileUploader.getContentPane().setLayout(null);
		
		JScrollPane scrollPane_1 = new JScrollPane();
		scrollPane_1.setBounds(20, 527, 598, 157);
		frmFileUploader.getContentPane().add(scrollPane_1);
		
		JTextArea textArea = new JTextArea();
		scrollPane_1.setViewportView(textArea);
		
		JLabel label = new JLabel("Server Address:");
		label.setBounds(20, 477, 112, 14);
		frmFileUploader.getContentPane().add(label);
		
		txthost = new JTextField();
		txthost.setText("localhost");
		txthost.setBounds(165, 473, 248, 22);
		frmFileUploader.getContentPane().add(txthost);
		txthost.setColumns(10);
		
		JFileChooser fileChooser = new JFileChooser();
		fileChooser.setBounds(20, 11, 600, 439);
		frmFileUploader.getContentPane().add(fileChooser);
		
		FileNameExtensionFilter filter = new FileNameExtensionFilter("MSWord", "doc", "docx");
		fileChooser.setFileFilter(filter);
		
		JButton btnConnectAndUpload = new JButton("Connect and Upload");
		btnConnectAndUpload.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) { 
				//Socket sock;
				try {
				   String filename=fileChooser.getSelectedFile().getName();
				   String path=fileChooser.getSelectedFile().getPath();
				   long length=fileChooser.getSelectedFile().length();
				   int portNum = 5520;
				   String hostAddress = txthost.getText();  
				   //sock = new Socket(hostAddress, portNum, filename, length );
				   
				   try {
				       sock = new Socket(hostAddress, portNum);
					   textArea.append("Connected.\n");
					   
					   // Creating file object of the file that we want to transfer
					   File transferableFile = new File(path);
					   
					   // initiating the byte array with the file size
				       byte[] bytearray = new byte[(int) transferableFile.length()];
				       FileInputStream input = new FileInputStream(transferableFile);
				       BufferedInputStream Bufferedinput = new BufferedInputStream(input);
				       DataInputStream dis = new DataInputStream(Bufferedinput);   
				       dis.readFully(bytearray, 0, bytearray.length);
				       OutputStream os = sock.getOutputStream();
				       
				       textArea.append("Sent file name: " + filename + "\n");
			           textArea.append("Sent file length: " + length + "\n");
				       
				       // Sending file name and file size to the server
				       DataOutputStream dos = new DataOutputStream(os);   
				       dos.writeUTF(transferableFile.getName());   
				       dos.writeLong(bytearray.length);   
				       dos.write(bytearray, 0, bytearray.length);   
				       dos.flush();
				        
			           textArea.append("Sending file ...\n");
				       
			           // Sending file data to the server
	  		           os.write(bytearray, 0, bytearray.length);
			           os.flush();
			           
			           textArea.append("File sent. Waiting for the server ... \n");
			           textArea.append("Upload O.K. \n");
	
			           //Closing socket
				       sock.close();
			           textArea.append("Disconnected.\n");

					} catch (IOException e1) {
						textArea.append("Error in connecting\n");
						//e1.printStackTrace();
					}
				} catch( NullPointerException n) {
				   textArea.append("No files selected\n");
				} 
			}
		});
		
		btnConnectAndUpload.setBounds(442, 473, 178, 23);
		frmFileUploader.getContentPane().add(btnConnectAndUpload);
		
		JLabel lblErrorMessages = new JLabel("Error Messages:");
		lblErrorMessages.setBounds(20, 502, 112, 14);
		frmFileUploader.getContentPane().add(lblErrorMessages);
	}
}
