<%--
Copyright 2017 Google Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--%>
<%@ page import="java.util.List" %>
<%@ page import="codeu.model.data.Conversation" %>
<%@ page import="codeu.model.data.Message" %>
<%@ page import="java.util.Date" %>

<!DOCTYPE html>
<html>
  <head>
    <title>Profile</title>
    <link rel="stylesheet" href="/css/main.css">
    </head>
    <body>

      <nav>
        <a id="navTitle" href="/">The Chat in the Hat</a>
        <% if(request.getSession().getAttribute("user") != null){ %>
          <a>Hello <%= request.getSession().getAttribute("user") %>!</a>
          <a href="/conversations">Conversations</a>
          <a href="/profile">Profile</a>
          <a href="/admin">Admin</a>
        <% } else{ %>
          <a href="/login">Login</a>
        <% } %>
        <a href="/about.jsp">About</a>
      </nav>

      <div id="container">
        <div
          style="width:75%; margin-left:auto; margin-right:auto; margin-top: 50px;">

          <%-- <h1>This is your profile page! </h1> --%>
          <hr/>
          <%-- <p> <%=request.getParameter("username")%> </p> --%>


          <%-- <%
          if ((request.getParameter("username")) != null && (request.getSession().getAttribute("user")!=null)){
            %>
            <p>You can edit your profile here</p>
            <% if (request.getParameter("username").equals(request.getSession().getAttribute("user"))){
              %> --%>
              <%-- <li>Edit profile<a href="/edit">here</a>.</li> --%>
              <%-- <div>
                <form action = "/profile" method = "POST">
                  <textarea name = "About_me_message" rows = "10" cols = "40">
                    who are you?
                  </textarea>
                  <br>
                    <input type = "Submit">
                      <%-- <%

                    }%>
                    <%
                  }%> --%>


                <%-- </div> --%>
                <h1> Welcome to <%=request.getAttribute("ownerUser")%>'s Profile Page </h1>

                <h5 style="color:blue"><%= request.getAttribute("about") %></h5>

                <%-- <p><%=%></p> --%>
                <% if (request.getSession().getAttribute("user") != null){
                  %>

                <% if (request.getSession().getAttribute("user").equals(request.getAttribute("ownerUser"))){
                  %>

                  <form action = "/users/<%=request.getSession().getAttribute("user")%>" method = "POST">
                  <label for="about">Edit my profile: </label>
                  <br/>
                  <div class = "form-group">
                    <textarea name = "about" id = "about" rows = "10" cols = "100" placeholder = "Enter some info about yourself!"></textarea>
                      <br/>
                        <input type = "Submit">
                        </form>
                        </div>
                        <%}%>
                        <%}%>





                <h1>Sent Messages</h1>
                <%
                List<Message> messages = (List<Message>)request.getAttribute("messages");
                if(messages == null || messages.isEmpty()){
                  %>
                  <p> No messages have been sent.</p>
                  <%
                }
                else{
                  %>
                  <ul class="mdl-list">
                    <%

                    for(Message eachMessage : messages){
                      %>

                      <li>
                        <%Date date = Date.from(eachMessage.getCreationTime());%>
                        <p><%= date %>: <p style="color:purple"><%= eachMessage.getContent() %></p> </p>
                        <%-- <h5> <%= date %> <a><%= eachMessage.getContent() %></a></h5> --%>
                      </li>
                        <%

                      }
                      %>
                    </ul>
                    <%
                  }
                  %>

                </div>
              </div>
            </body>
          </html>
