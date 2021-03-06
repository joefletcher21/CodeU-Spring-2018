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

      <h1>Access Denied</h1>
      <p>you must be an admin to access this page<p>

    </div>
  </div>
</body>
</html>
