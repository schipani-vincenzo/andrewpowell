package flex.samples.jms;

import java.util.*;
import java.awt.*;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.jms.*;
import javax.naming.*;
import javax.swing.*;

public class Chat implements MessageListener, ActionListener {

    private TopicSession 	_pubSession = null;
    private TopicSession 	_subSession = null;
    private TopicPublisher 	_publisher 	= null;
    private TopicConnection _connection = null;

    private String _providerurl = "localhost:1099";
    private String _ctxtFactory = "org.jboss.naming.NamingContextFactory";
    
    private JTextField tfUser;
    private JTextField tfMessage;
    private JTextArea taChat;

    public static void main(String args[]) {
        new Chat();
    }

    public Chat() {

        try {
            // Obtain JNDI Context
            Properties p = new Properties();
            p.put(Context.PROVIDER_URL, _providerurl);
            p.put(Context.INITIAL_CONTEXT_FACTORY, _ctxtFactory);
            //specific to your app server setup
            p.put(Context.SECURITY_PRINCIPAL, "admin");
            p.put(Context.SECURITY_CREDENTIALS , "admin");
            Context context = new InitialContext(p);

            TopicConnectionFactory factory = (TopicConnectionFactory) context.lookup("ConnectionFactory");

            // Create a JMS connection
            _connection = factory.createTopicConnection();

            // Create publisher session
            _pubSession = _connection.createTopicSession(false, Session.AUTO_ACKNOWLEDGE);

            // Create subscriber session
            _subSession = _connection.createTopicSession(false, Session.AUTO_ACKNOWLEDGE);

            // Lookup a JMS topic, needs to match what you'll use in your flex messaging config file
            // (and in JRun jrun-resources.xml)
            Topic topic = (Topic) context.lookup("topic/chatTopic");

            // Create a publisher and a subscriber
            _publisher = _pubSession.createPublisher(topic);
            TopicSubscriber subscriber=_subSession.createSubscriber(topic);

            // Set JMS message listener
            subscriber.setMessageListener(this);

            // Start the JMS connection; allows messages to be delivered
            _connection.start();

        } catch (NamingException e) {
            e.printStackTrace();
        } catch (JMSException e) {
            e.printStackTrace();
        }

        // Build user interface
        JFrame frame = new JFrame("JMS Chat");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        taChat = new JTextArea();
        frame.getContentPane().add(taChat, BorderLayout.CENTER);

        Box north = new Box(BoxLayout.X_AXIS);
        north.add(new JLabel("User Name:"));
        tfUser = new JTextField();
        north.add(tfUser);
        frame.getContentPane().add(north, BorderLayout.NORTH);


        Box south = new Box(BoxLayout.X_AXIS);
        south.add(new JLabel("Message:"));
        tfMessage = new JTextField();
        south.add(tfMessage);
        JButton btSend = new JButton("Send");
        btSend.addActionListener(this);
        south.add(btSend);
        frame.getContentPane().add(south, BorderLayout.SOUTH);

        int width = 300;
        int height = 300;
        frame.setSize(width, height);
        frame.setVisible(true);

    }

    public void onMessage(Message obj) {
        try {
            ObjectMessage message = (ObjectMessage) obj;
            Map body = (Map) message.getObject();
            //String userId = message.getStringProperty("userId");
            //String msg = message.getStringProperty("msg");
            String userId = (String)body.get("userId");
            String msg = (String)body.get("msg");
            taChat.append(userId + ":  " + msg + "\n");
        } catch (JMSException e) {
            e.printStackTrace();
        }
    }

    public void actionPerformed(ActionEvent e) {
        try {
            ObjectMessage message = _pubSession.createObjectMessage();
            HashMap body = new HashMap();
            body.put("userId", tfUser.getText());
            body.put("msg", tfMessage.getText());
            message.setObject(body);
            //message.setStringProperty("userId", tfUser.getText());
            //message.setStringProperty("msg", tfMessage.getText());
            _publisher.publish(message, Message.DEFAULT_DELIVERY_MODE, Message.DEFAULT_PRIORITY, 5 * 60 * 1000);
        } catch (JMSException e1) {
            e1.printStackTrace();
        }

    }

}