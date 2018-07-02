package codeu.controller;

import codeu.model.data.User;
import codeu.model.store.basic.UserStore;
import codeu.model.data.Conversation;
import codeu.model.store.basic.ConversationStore;
import codeu.model.data.Message;
import codeu.model.store.basic.MessageStore;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;


public class AdminServlet extends HttpServlet{


	/** Store class that gives access to Users. */
	private UserStore userStore;
	private ConversationStore conversationStore;
	private MessageStore messageStore;


  /**
   * Set up state for handling ------------------------ requests. This method is only called when running in a
   * server, not when running in a test.
   */
  @Override
  public void init() throws ServletException {
    super.init();
    setUserStore(UserStore.getInstance());
    setConversationStore(ConversationStore.getInstance());
    setMessageStore(MessageStore.getInstance());
  }

    /**
   * Sets the UserStore used by this servlet. This function provides a common setup method for use
   * by the test framework or the servlet's init() function.
   */
  void setUserStore(UserStore userStore) {
    this.userStore = userStore; 
  }

  void setConversationStore(ConversationStore conversationStore){
  	this.conversationStore= conversationStore;
  }

  void setMessageStore(MessageStore messageStore) {
    this.messageStore = messageStore; 
  }

    /**
   * This function fires when a user requests the /admin URL. It simply forwards the request to
   * profile.jsp.
   */
  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
      	String username = (String) request.getSession().getAttribute("user");
      	User user = userStore.getUser(username);
      	if (user==null){
      		request.getRequestDispatcher("/WEB-INF/view/accessdenied.jsp").forward(request, response);
      	}
    	else if (user.getIsAdmin()){
    		List<Conversation> conversations = conversationStore.getAllConversations();
    		request.setAttribute("conversations", conversations);
    		List<User> users = userStore.getAllUsers();
    		request.setAttribute("users", users);
    		List<Message> messages = messageStore.getAllMessages();
    		request.setAttribute("messages", messages);
      		request.getRequestDispatcher("/WEB-INF/view/admin.jsp").forward(request, response);

      	}else{
      		request.getRequestDispatcher("/WEB-INF/view/accessdenied.jsp").forward(request, response);
      	}
      	
    }  
}
