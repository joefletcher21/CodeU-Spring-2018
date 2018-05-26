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
    <% } else{ %>
      <a href="/login">Login</a>
    <% } %>
    <a href="/conversations">Conversations</a>
    <a href="/about">About</a>
    <% if(request.getSession().getAttribute("user") != null){ %>
      <a href="/users/<%=request.getSession().getAttribute("user")%>">Profile</a>
    <% }  %>
    <a href="/activityfeed">Activity</a>
  </nav>

  <div id="container">
    <div
      style="width:75%; margin-left:auto; margin-right:auto; margin-top: 50px;">

      <%-- <h1>This is your profile page! </h1> --%>
      <hr/>

      <h1>Messages</h1>

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
      <li><a href="/chat/<%= eachMessage.getAuthorId() %>">
        <%= eachMessage.getContent() %></a></li>
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
