package Server_Side;

import javax.swing.*;
import javax.swing.Timer;
import javax.swing.border.*;
import javax.swing.plaf.ScrollBarUI;
import javax.swing.plaf.basic.BasicScrollBarUI;
import java.awt.*;
import java.awt.event.*;
import java.net.*;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

public class Server implements ActionListener {

    JPanel P1;
    JTextField t1;
    JButton b1;
    static JPanel A1;
    static ServerSocket skt;
    static Socket sock;
    static DataInputStream din;
    static DataOutputStream dout;

    static JFrame F1= new JFrame();

    static Box vertical = Box.createVerticalBox();

    boolean typing;
    public Server(){
        F1.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        P1=new JPanel();
        P1.setLayout(null);
        P1.setBackground(new Color(243,179,64));
        P1.setBounds(0,0,470,70);
        F1.add(P1);



        /*setting back option image*/

        ImageIcon I1=new ImageIcon(ClassLoader.getSystemResource("Server_Side/Icon/back.png"));
        Image i2=I1.getImage().getScaledInstance(50,50,Image.SCALE_DEFAULT);
        ImageIcon I3=new ImageIcon(i2);
        JLabel l1=new JLabel(I3);
        l1.setBounds(410,10,50,50);
        P1.add(l1);

        // perform events of back option
        l1.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                super.mouseClicked(e);
                System.exit(0);
            }
        });

        /*setting image option image*/

        ImageIcon I4=new ImageIcon(ClassLoader.getSystemResource("Server_Side/Icon/Omen.png"));
        Image i3=I4.getImage().getScaledInstance(50,50,Image.SCALE_DEFAULT);
        ImageIcon I5=new ImageIcon(i3);
        JLabel l2=new JLabel(I5);
        l2.setBounds(5,10,50,50);
        P1.add(l2);

        /* adding names*/

        JLabel l3 =new JLabel("Pikachu");
        l3.setFont(new Font("SAN_SERIF",Font.BOLD,24));
        l3.setForeground(Color.WHITE);
        l3.setBounds(68,18,100,20);
        P1.add(l3);

        /* adding active status*/

        JLabel l4 =new JLabel("Active now");
        l4.setFont(new Font("SAN_SERIF",Font.PLAIN,10));
        l4.setForeground(Color.WHITE);
        l4.setBounds(70,37,100,20);
        P1.add(l4);

        //adding timer for typing status
        Timer T1= new Timer(1, new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if (!typing)
                    l4.setText("Active Now");
            }
        });
        T1.setInitialDelay(2000);


        //qdding text field

        t1= new JTextField();
        t1.setBounds(1,559,390,40);
        t1.setFont(new Font("SAN_SERIF",Font.PLAIN,16));
        F1.add(t1);

        // adding key listener to check for typing status
        t1.addKeyListener(new KeyAdapter() {
            @Override
            public void keyPressed(KeyEvent e) {
                super.keyPressed(e);
                l4.setText("typing...");
                T1.stop();
                typing=true;
            }

            @Override
            public void keyReleased(KeyEvent e) {
                super.keyReleased(e);
                typing=false;
                if (!T1.isRunning())
                    T1.start();
            }
        });

        //adding send button

        b1= new JButton("Send");
        b1.setBounds(396,559,70,40);
        b1.setBackground(new Color(243,179,64));
        b1.setForeground(Color.WHITE);
        b1.setFont(new Font("SAN_SERIF", Font.PLAIN,16));
        b1.addActionListener(this);
        F1.add(b1);

        // adding text area to display messages

        A1=new JPanel();
        A1.setFont(new Font("SAN_SERIF",Font.PLAIN,16));
        JScrollPane sp=new JScrollPane(A1);
        sp.setBounds(5,75,460,480);

        sp.setBorder(BorderFactory.createEmptyBorder());

        ScrollBarUI ui=new BasicScrollBarUI(){
            protected JButton createDecreaseButton(int orientation){
                JButton button =super.createDecreaseButton(orientation);
                button.setBackground(new Color(243,179,64));
                button.setForeground(Color.WHITE);
                this.thumbColor=new Color(243,179,64);
                return button;
            }

            protected JButton createIncreaseButton(int orientation){
                JButton button =super.createIncreaseButton(orientation);
                button.setBackground(new Color(7,94,84));
                button.setForeground(Color.WHITE);
                this.thumbColor=new Color(7,94,84);
                return button;
            }
        };
        sp.getVerticalScrollBar().setUI(ui);
        F1.add(sp);

        /*setting chat box properties*/

        F1.getContentPane().setBackground(new Color(244, 243, 239));
        F1.setLayout(null);
        F1.setSize(470,600);
        F1.setLocation(450,160);
        F1.setUndecorated(true);
        F1.setVisible(true);

    }

    public void actionPerformed(ActionEvent e){
        try {
            String out = t1.getText();
            Transfer_chat(out);
            JPanel p2=formatLabel(out);
            A1.setLayout(new BorderLayout());
            JPanel right=new JPanel(new BorderLayout());
            right.add(p2, BorderLayout.LINE_END);
            vertical.add(right);
            vertical.add(Box.createVerticalStrut(15));

            A1.add(vertical, BorderLayout.PAGE_START);

            dout.writeUTF(out);
            t1.setText("");
        }
        catch(Exception exp){
        }
    }

    public void Transfer_chat(String text) throws FileNotFoundException{
        try(FileWriter file=new FileWriter("chat.txt",true);
            PrintWriter p=new PrintWriter(new BufferedWriter(file));){
            p.println("Admin: "+text);
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }

    public static JPanel formatLabel(String out){
        JPanel p3=new JPanel();
        p3.setLayout(new BoxLayout(p3,BoxLayout.Y_AXIS));

        JLabel l1=new JLabel("<html> <p style=\"width : 150px\">"+out+"</p></html>");
        l1.setFont(new Font("Tahoma",Font.PLAIN,16));
        l1.setBackground(new Color(243,179,64));
        l1.setOpaque(true);
        l1.setBorder(new EmptyBorder(5,5,5,5));

        Calendar cal= Calendar.getInstance();
        SimpleDateFormat sdf= new SimpleDateFormat(("HH:mm"));

        JLabel l2= new JLabel();
        l2.setText(sdf.format(cal.getTime()));

        p3.add(l1);
        p3.add(l2);
        return p3;
    }

    public static void main(String args[]){

        new Server().F1.setVisible(true);

        String msginput="";
        try{
            skt=new ServerSocket(8001);
            sock=skt.accept();
            din= new DataInputStream(sock.getInputStream());
            dout=new DataOutputStream(sock.getOutputStream());

            while (true){
                msginput= din.readUTF();
                JPanel p2=formatLabel(msginput);

                JPanel left= new JPanel(new BorderLayout());
                left.add(p2,BorderLayout.LINE_START);
                vertical.add(left);
                F1.validate();

            }
        }
        catch (Exception e){
        }
    }
}