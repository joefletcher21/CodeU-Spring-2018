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
<%@ page import="codeu.model.store.basic.UserStore" %>
<%
Conversation conversation = (Conversation) request.getAttribute("conversation");
List<Message> messages = (List<Message>) request.getAttribute("messages");
%>

<!DOCTYPE html>
<html>
<head>
  <title><%= conversation.getTitle() %></title>
  <link rel="stylesheet" href="/css/main.css" type="text/css">

  <style>
    #chat {
      background-color: white;
      height: 500px;
      overflow-y: scroll
    }
    a.delete-button {
      visibility: hidden;
    }
  </style>

  <script>
    // scroll the chat div to the bottom
    function scrollChat() {
      var chatDiv = document.getElementById('chat');
      chatDiv.scrollTop = chatDiv.scrollHeight;
    };
  </script>
</head>
<body onload="scrollChat()">

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

    <h1><%= conversation.getTitle() %>
      <a href="" style="float: right">&#8635;</a></h1>
    <button onclick="deleteButtons()">Delete</button>
    <hr/>

    <div id="chat">
      <ul>
    <%
      for (Message message : messages) {
        String author = UserStore.getInstance()
          .getUser(message.getAuthorId()).getName();

    %>
      <li><strong><%= author %>:</strong> <%= message.getContent() %>
      <div align="right">
        <form action="/delete/<%= message.getId() %>" method= "POST" class="delete-button">
        <button type="submit">delete</button>
        </form>
      </div>
      </li>
    <%
      }
    %>
      </ul>
    </div>

    <script>
        function deleteButtons() {
          var delete_buttons = document.getElementsByClassName("delete-button");
          for (var button of delete_buttons){

            if (button.style.visibility === "hidden") {
              button.style.visibility = "visible";
              console.log(button);
            } else {
              button.style.visibility = "hidden";
            }
          }
        }
    </script>

    <hr/>

    <% if (request.getSession().getAttribute("user") != null) { %>
    <form action="/chat/<%= conversation.getTitle() %>" method="POST">
        <input type="text" name="message">
         Style characters (Put the text you want styled in place of the dots)
         <ul>
           Bold: &lt;b&gt;...&lt;/b&gt
           Italics: &lt;i&gt;...&lt;/i&gt
           Underline: &lt;u&gt;...&lt;/u&gt
           Strikethrough: &lt;strike&gt;...&lt;/strike&gt
         </ul>
        <br/>
        <button type="submit">Send</button>
    </form>
    <% } else { %>
      <p><a href="/login">Login</a> to send a message.</p>
    <% } %>

    <hr/>

  </div>

</body>
</html>
