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
<%@ page import="codeu.model.data.Conversation" %>
<%@ page import="codeu.model.data.User" %>
<%@ page import="codeu.model.data.Message" %>
<%@ page import="codeu.model.store.basic.MessageStore" %>
<%@ page import= "codeu.model.store.basic.ConversationStore" %>
<%@ page import= "codeu.model.store.basic.UserStore" %>
<%@ page import="java.util.List" %>


<!DOCTYPE html>
<html>
<head>
  <title>Activity Feed</title>
  <link rel="stylesheet" href="/css/main.css">
</head>
<body>

  <nav>
  <a id="navTitle" href="/">The Chat in the Hat</a>
  <% if(request.getSession().getAttribute("user") != null){ %>
    <a>Hello <%= request.getSession().getAttribute("user") %>!</a>
    <a href="/conversations">Conversations</a>
    <a href="/users/<%=request.getSession().getAttribute("user")%>">Profile</a>
    <a href="/admin">Admin</a>
  <% } else{ %>
    <a href="/login">Login</a>
    <a href="/conversations">Conversations</a>
  <% } %>
  <a href="/about.jsp">About</a>
</nav>

  <div id="container">
    <div
      style="width:75%; margin-left:auto; margin-right:auto; margin-top: 50px;">
      <h1>Administration</h1>
      <hr>
      <h3>Site Statistics</h3>
      <p>
        Here are some site statistics:
      </p>

      <ul>
      <%
      List<Conversation> conversations = (List<Conversation>) request.getAttribute("conversations");
      List<User> users = (List<User>) request.getAttribute("users");
      List<Message> messages = (List<Message>) request.getAttribute("messages");
        %>
        <li><strong>Conversations: </strong> <%= conversations.size() %> </li>
        <li><strong>Users: </strong> <%= users.size() %> </li>
        <li><strong>Messages: </strong> <%= messages.size() %> </li>
      </ul>

    </div>
  </div>
</body>
</html>
