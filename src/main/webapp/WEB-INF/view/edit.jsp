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
<!DOCTYPE html>
<html>
<head>
  <title>Login</title>
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
    <a href="/about.jsp">About</a>
    <% if(request.getSession().getAttribute("user") != null){ %>
      <a href="/users/<%=request.getSession().getAttribute("user")%>">Profile</a>
    <% } %>
    <a href="/activityfeed">Activity</a>
  </nav>

  <div id="container">
    <h1>Edit your profile:</h1>

    <% if(request.getAttribute("error") != null){ %>
        <h2 style="color:red"><%= request.getAttribute("error") %></h2>
    <% } %>

    <div>
      <form action = "/edit" method = "POST">
        <textarea name = "About_me_message" rows = "10" cols = "40">
        </textarea>
        <br>
          <input type = "Save">
            <%-- <%

          }%>
          <%
        }%> --%>


      </div>

    <%-- <form action="/edit" method="POST">
      <label for="editPage">Edit: </label>
      <br/>
      <input type="text" name="editPage" id="editPage">
      <br/>
      <%-- <label for="password">Password: </label>
      <br/>
      <input type="password" name="password" id="password">
      <br/><br/> --%>
      <%-- <button type="save">Save</button>
    </form> --%>

    <p>Return to profile <a href="/profile">:</a>.</p>
  </div>
</body>
</html>