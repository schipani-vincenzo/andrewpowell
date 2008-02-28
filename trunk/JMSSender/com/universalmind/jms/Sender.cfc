<!--- 
JBossMQ Queue Sender

Created:  	 1/9/07
Created By:  Andrew Powell (andrew.powell@universalmind.com)
Description:


 --->

<cfcomponent output="false">
	
	<cfproperty name="server" 		type="string"/>
	<cfproperty name="port"	  		type="string"/>
	<cfproperty name="type"	  		type="string"/>
	<cfproperty name="topic"  		type="string"/>
	<cfproperty name="queue"  		type="string"/>
	<cfproperty name="factory"		type="string"/>
	
	<cffunction name="init" access="public" returntype="com.universalmind.jms.Sender" output="false">
		<cfargument name="server" 	type="string" required="false" default="127.0.0.1"		/>
		<cfargument name="port"	  	type="string" required="false" default="1099"					/>
		<cfargument name="type"	  	type="string" required="false" default="queue"					/>
		<cfargument name="topic" 	type="string" required="false" default="topic/testTopic"		/>
		<cfargument name="queue"  	type="string" required="false" default="queue/A"				/>
		<cfargument name="factory"	type="string" required="false" default="java:/JmsXA"			/>
		
		<cfset variables.TO 		= structNew()			/>
		
		<cfset variables.TO.server 	= arguments.server		/>
		<cfset variables.TO.port 	= arguments.port		/>
		<cfset variables.TO.type 	= arguments.type		/>
		<cfset variables.TO.topic 	= arguments.topic		/>
		<cfset variables.TO.queue 	= arguments.queue		/>
		<cfset variables.TO.factory = arguments.factory		/>
		
		
		<cfreturn this/>
	</cffunction>
	
	<cffunction name="setServer" access="public" returntype="void" output="false">
		<cfargument name="server" type="string" required="true"/>
		<cfset variables.TO.server = arguments.server/>
	</cffunction>
	
	<cffunction name="getServer" access="public" returntype="void" output="false">
		<cfreturn variables.TO.server/>
	</cffunction>
	
	<cffunction name="setPort" access="public" returntype="void" output="false">
		<cfargument name="port" type="string" required="true"/>
		<cfset variables.TO.port = arguments.server/>
	</cffunction>
	
	<cffunction name="getPort" access="public" returntype="void" output="false">
		<cfreturn variables.TO.port/>
	</cffunction>
	
	<cffunction name="setType" access="public" returntype="void" output="false">
		<cfargument name="type" type="string" required="true"/>
		<cfset variables.TO.type = arguments.server/>
	</cffunction>
	
	<cffunction name="getType" access="public" returntype="void" output="false">
		<cfreturn variables.TO.type/>
	</cffunction>
	
	<cffunction name="setTopic" access="public" returntype="void" output="false">
		<cfargument name="topic" type="string" required="true"/>
		<cfset variables.TO.topic = arguments.server/>
	</cffunction>
	
	<cffunction name="getTopic" access="public" returntype="void" output="false">
		<cfreturn variables.TO.topic/>
	</cffunction>
	
	<cffunction name="setQueue" access="public" returntype="void" output="false">
		<cfargument name="queue" type="string" required="true"/>
		<cfset variables.TO.queue = arguments.server/>
	</cffunction>
	
	<cffunction name="getQueue" access="public" returntype="void" output="false">
		<cfreturn variables.TO.queue/>
	</cffunction>
	
	<cffunction name="sendQueueTextMessage" access="private" returntype="void" output="false">
		<cfargument name="message" type="string" required="true"/>
		
			<cfthread name="jmsTextSender-#createUUID()#" action="run" jmsProps="#variables.TO#" message="#arguments.message#">
		
			<cfscript>
				// queue Name 
				queueName = jmsProps.queue;
				 
				qcf = jmsProps.factory;
				 
				
				ctx = createObject("java","javax.naming.Context");
				prop = createObject("java","java.util.Properties").init();
				
				prop.put(ctx.PROVIDER_URL, "jnp://" & jmsProps.server & ":" & jmsProps.port & "/");
				prop.put(ctx.INITIAL_CONTEXT_FACTORY, "org.jboss.naming.NamingContextFactory");
				
				//prop.put (ctx.SECURITY_PRINCIPAL, "anonymous"); 
				//prop.put (ctx.SECURITY_CREDENTIALS, "anonymous");
				 
				ic = createObject("java","javax.naming.InitialContext").init(prop);
				
				//Step 1 = Look Up a Connection Factory in JNDI 
				queueConnectionFactory = ic.lookup(qcf);
				
				//Step 2 = Look Up a Destination Queue 
				queue = ic.lookup(queueName);
				
				//Step 3 = Create a Connection Using the Connection Factory 
				qc = queueConnectionFactory.createQueueConnection();
				
				//Step 4 = Create a Session Using the Connection 
				qs = qc.createQueueSession(false,1);
				
				//Step 5 = Create Message Producers 
				sender = qs.createSender(queue);
				
				//Step 6 = create ascii text message 
				objMsg = qs.createTextMessage();
				objMsg.setText(message);
				
				//Step 7 = Start the queue & send the message 
				qc.start ();
				
				deliveryMode = createObject("java","javax.jms.DeliveryMode");
				sender.send(objMsg, deliveryMode.PERSISTENT, 4, 0);
				
				//Step 8 = Close the queue;
				qs.close();
				qc.close();
				</cfscript>
			
			</cfthread>
	
	</cffunction>
	
	<cffunction name="sendQueueObjectMessage" access="private" returntype="void" output="false">
		<cfargument name="message" type="any" required="true"/>
		
			<cfthread name="jmsObjectSender-#createUUID()#" action="run" jmsProps="#variables.TO#" message="#arguments.message#">
		
			<cfscript>
				// queue Name 
				queueName = jmsProps.queue;
				 
				qcf = jmsProps.factory;
				 
				
				ctx = createObject("java","javax.naming.Context");
				prop = createObject("java","java.util.Properties").init();
				
				prop.put(ctx.PROVIDER_URL, "jnp://" & jmsProps.server & ":" & jmsProps.port & "/");
				prop.put(ctx.INITIAL_CONTEXT_FACTORY, "org.jboss.naming.NamingContextFactory");
				
				//prop.put (ctx.SECURITY_PRINCIPAL, "anonymous"); 
				//prop.put (ctx.SECURITY_CREDENTIALS, "anonymous");
				 
				ic = createObject("java","javax.naming.InitialContext").init(prop);
				
				//Step 1 = Look Up a Connection Factory in JNDI 
				queueConnectionFactory = ic.lookup(qcf);
				
				//Step 2 = Look Up a Destination Queue 
				queue = ic.lookup(queueName);
				
				//Step 3 = Create a Connection Using the Connection Factory 
				qc = queueConnectionFactory.createQueueConnection();
				
				//Step 4 = Create a Session Using the Connection 
				qs = qc.createQueueSession(false,1);
				
				//Step 5 = Create Message Producers 
				sender = qs.createSender(queue);
				
				//Step 6 = create ascii text message 
				objMsg = qs.createObjectMessage();
				objMsg.setObject(message);
				
				//Step 7 = Start the queue & send the message 
				qc.start ();
				
				deliveryMode = createObject("java","javax.jms.DeliveryMode");
				sender.send(objMsg, deliveryMode.PERSISTENT, 4, 0);
				
				//Step 8 = Close the queue;
				qs.close();
				qc.close();
				</cfscript>
			
			</cfthread>
	
	</cffunction>
	
	<cffunction name="sendTopicTextMessage" access="private" returntype="void" output="false">
		<cfargument name="message" type="string" required="true"/>
		
			<cfthread name="jmsTextSender-#createUUID()#" action="run" jmsProps="#variables.TO#" message="#arguments.message#">
		
			<cfscript>
				// queue Name 
				topicName = jmsProps.topic;
				 
				qcf = jmsProps.factory;
				 
				
				ctx = createObject("java","javax.naming.Context");
				prop = createObject("java","java.util.Properties").init();
				
				prop.put(ctx.PROVIDER_URL, "jnp://" & jmsProps.server & ":" & jmsProps.port & "/");
				prop.put(ctx.INITIAL_CONTEXT_FACTORY, "org.jboss.naming.NamingContextFactory");
				
				//prop.put (ctx.SECURITY_PRINCIPAL, "anonymous"); 
				//prop.put (ctx.SECURITY_CREDENTIALS, "anonymous");
				 
				ic = createObject("java","javax.naming.InitialContext").init(prop);
				
				//Step 1 = Look Up a Connection Factory in JNDI 
				topicConnectionFactory = ic.lookup(qcf);
				
				//Step 2 = Look Up a Destination Topic Factory 
				topic = ic.lookup(topicName);
				
				//Step 3 = Create a Connection Using the Connection Factory 
				tc = queueConnectionFactory.createTopicConnection();
				
				//Step 4 = Create a Session Using the Connection 
				qs = qc.createTopicSession(false,1);
				
				//Step 5 = Create Message Producers 
				sender = qs.createPublisher(topic);
				
				//Step 6 = create ascii text message 
				txtMsg = qs.createTextMessage();
				txtMsg.setText(message);
				
				//Step 7 = Start the queue & send the message 
				qc.start ();
				
				deliveryMode = createObject("java","javax.jms.DeliveryMode");
				sender.publish(txtMsg, deliveryMode.PERSISTENT, 4, 0);
				
				//Step 8 = Close the queue;
				qs.close();
				qc.close();
				</cfscript>
			
			</cfthread>
	
	</cffunction>
	
	<cffunction name="sendTopicObjectMessage" access="private" returntype="void" output="false">
		<cfargument name="message" type="string" required="true"/>
		
			<cfthread name="jmsTextSender-#createUUID()#" action="run" jmsProps="#variables.TO#" message="#arguments.message#">
		
			<cfscript>
				// queue Name 
				topicName = jmsProps.topic;
				 
				qcf = jmsProps.factory;
				 
				
				ctx = createObject("java","javax.naming.Context");
				prop = createObject("java","java.util.Properties").init();
				
				prop.put(ctx.PROVIDER_URL, "jnp://" & jmsProps.server & ":" & jmsProps.port & "/");
				prop.put(ctx.INITIAL_CONTEXT_FACTORY, "org.jboss.naming.NamingContextFactory");
				
				//prop.put (ctx.SECURITY_PRINCIPAL, "anonymous"); 
				//prop.put (ctx.SECURITY_CREDENTIALS, "anonymous");
				 
				ic = createObject("java","javax.naming.InitialContext").init(prop);
				
				//Step 1 = Look Up a Connection Factory in JNDI 
				topicConnectionFactory = ic.lookup(qcf);
				
				//Step 2 = Look Up a Destination Topic Factory 
				topic = ic.lookup(topicName);
				
				//Step 3 = Create a Connection Using the Connection Factory 
				tc = queueConnectionFactory.createTopicConnection();
				
				//Step 4 = Create a Session Using the Connection 
				qs = qc.createTopicSession(false,1);
				
				//Step 5 = Create Message Producers 
				sender = qs.createPublisher(topic);
				
				//Step 6 = create ascii text message 
				objMsg = qs.createObjectMessage();
				objMsg.setObject(message);
				
				//Step 7 = Start the queue & send the message 
				qc.start ();
				
				deliveryMode = createObject("java","javax.jms.DeliveryMode");
				sender.publish(objMsg, deliveryMode.PERSISTENT, 4, 0);
				
				//Step 8 = Close the queue;
				qs.close();
				qc.close();
				</cfscript>
			
			</cfthread>
	
	</cffunction>
	
	
	<cffunction name="send" access="public" returntype="void" output="false">
		<cfargument name="message" type="any" required="true"/>
		
		<cfif isSimpleValue(arguments.message) AND getType() EQ "queue">
			<cfset sendQueueTextMessage(arguments.message)/>
			<cfelseif getType() EQ "queue">
				<cfset sendQueueObjectMessage(arguments.message)/>
				<cfelseif isSimpleValue(arguments.message) AND getType() EQ "topic">
					<cfset sentTopicTextMessage(arguments.message)/>
					<cfelseif getType() EQ "topic">
						<cfset sendTopicObjectMessage(arguments.message)/>
		</cfif>
	</cffunction>
	
</cfcomponent>