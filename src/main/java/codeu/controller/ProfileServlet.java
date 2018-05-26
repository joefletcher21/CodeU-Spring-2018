package codeu.controller;

import java.io.IOException;
import java.time.Instant;
import java.util.UUID;
import java.util.List;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mindrot.jbcrypt.BCrypt;

import codeu.model.data.User;
import codeu.model.store.basic.UserStore;
import codeu.model.store.basic.MessageStore;
import codeu.model.data.Message;

public class ProfileServlet extends HttpServlet {

  /** Store class that gives access to Users. */
  private UserStore userStore;
  private MessageStore messageStore;

  /**
  * Set up state for handling registration-related requests. This method is only called when
  * running in a server, not when running in a test.
  */
  @Override
  public void init() throws ServletException {
    super.init();
    setUserStore(UserStore.getInstance());
    setMessageStore(MessageStore.getInstance());
  }

  /**
  * Sets the UserStore used by this servlet. This function provides a common setup method for use
  * by the test framework or the servlet's init() function.
  */
  void setUserStore(UserStore userStore) {
    this.userStore = userStore;
  }
  void setMessageStore(MessageStore messageStore) {
    this.messageStore = messageStore;
  }

  /**
  * This function fires when a user requests the /profile URL. It simply forwards the request to
  * profile.jsp.
  */
  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response)
  throws IOException, ServletException {
    String requestUrl = request.getRequestURI();
    int indexOfUser = requestUrl.indexOf("/users/");
    System.out.println("index of user: "+indexOfUser);
    String usernameUrl = requestUrl.substring(indexOfUser+"/users/".length(), requestUrl.length());
    System.out.println("name of user: "+usernameUrl);
    User currentUser = userStore.getUser(usernameUrl);
    List<Message> currentUserMessages = new ArrayList<Message>();
    if (currentUser != null){
      currentUserMessages = messageStore.getUserMessages( currentUser.getId());
      System.out.println("in the null if statement");
    }
    System.out.println(currentUserMessages.size());
    request.setAttribute("messages", currentUserMessages);
    request.setAttribute("user", usernameUrl);
    request.getRequestDispatcher("/WEB-INF/view/profile.jsp").forward(request, response);

  }
}
