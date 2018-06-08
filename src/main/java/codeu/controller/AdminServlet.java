package codeu.controller;

import codeu.model.data.User;
import codeu.model.store.basic.UserStore;
import codeu.model.data.Conversation;
import codeu.model.store.basic.ConversationStore;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mindrot.jbcrypt.BCrypt;


public class AdminServlet extends HttpServlet{


	/** Store class that gives access to Users. */
	private UserStore userStore;
	private ConversationStore conversationStore;


  /**
   * Set up state for handling ------------------------ requests. This method is only called when running in a
   * server, not when running in a test.
   */
  @Override
  public void init() throws ServletException {
    super.init();
    setUserStore(UserStore.getInstance());
    setConversationStore(ConversationStore.getInstance());
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
      		request.getRequestDispatcher("/WEB-INF/view/admin.jsp").forward(request, response);
      	}else{
      		request.getRequestDispatcher("/WEB-INF/view/accessdenied.jsp").forward(request, response);
      	}
      	
    }  
}
