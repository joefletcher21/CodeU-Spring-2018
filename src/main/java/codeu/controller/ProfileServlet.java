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
    // if (indexOfUser >= 0){
    System.out.println("index of user: "+indexOfUser);
    String usernameUrl = requestUrl.substring(indexOfUser+"/users/".length(), requestUrl.length());
    System.out.println("name of user: "+usernameUrl);
    User currentUser = userStore.getUser(usernameUrl);

    String aboutCurrentUser;
    if ((currentUser != null) && (currentUser.getAboutMe() != null)){
      aboutCurrentUser = currentUser.getAboutMe();
    }
    // delete later:
    else{
      aboutCurrentUser = "No profile has been created";
    }

    List<Message> currentUserMessages = new ArrayList<Message>();
    if (currentUser != null){
      currentUserMessages = messageStore.getUserMessages( currentUser.getId());
      System.out.println("in the null if statement");
    }

    System.out.println(currentUserMessages.size());
    request.setAttribute("about", aboutCurrentUser);
    request.setAttribute("messages", currentUserMessages);
    request.setAttribute("user", usernameUrl);
    request.setAttribute("currentUser", currentUser);
    // request.setAttribute("username", request.getRemoteUser ());
    // System.out.println("username get aram: "+request.getRemoteUser ());

    request.getRequestDispatcher("/WEB-INF/view/profile.jsp").forward(request, response);

  }

  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response)
  throws IOException, ServletException {
    String username = (String) request.getSession().getAttribute("user");

    if (username == null) {
      // user is not logged in, don't let them create a conversation
      response.sendRedirect("/login");
      return;
    }

    User user = userStore.getUser(username);
    if (user == null) {
      // user was not found, don't let them create a conversation
      System.out.println("User not found: " + username);
      response.sendRedirect("/login");
      return;
    }
    System.out.println("didnt go in nulls and in POST");
    response.sendRedirect("/users/"+username);

  }
}
