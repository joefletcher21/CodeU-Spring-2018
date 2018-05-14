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
  <title>CodeU Chat App</title>
  <link rel="stylesheet" href="/css/main.css">
</head>
<body>

  <nav>
    <a id="navTitle" href="/">CodeU Chat App</a>
    <a href="/conversations">Conversations</a>
    <% if(request.getSession().getAttribute("user") != null){ %>
      <a>Hello <%= request.getSession().getAttribute("user") %>!</a>
    <% } else{ %>
      <a href="/login">Login</a>
    <% } %>
    <a href="/about.jsp">About</a>
  </nav>

  <div id="container">
    <div
      style="width:75%; margin-left:auto; margin-right:auto; margin-top: 50px;">

      <h1>About the CodeU Chat App</h1>
      <p>
        The Chat in the Hat is designed by:
      </p>

      <ul>
        <li><strong>Blair Bucshon:</strong> Blair is finishing up her sophomore year at Cornell University.</li>
        <li><strong> She is orginially from Indiana but now lives in Washington DC.
          Blair really enjoys photography and hopes to be able to find 
          some new places to take photos this summer! </li>
          
        <li><strong>Hafsah Hanif:</strong> Hafsah is a rising junior at Smith College.</li>
        <li><strong> She studies Computer Science and Government, and hopes to attend law school in the future. 
          Hafsah really enjoys playing tennis and hiking! </li>
        
        <li><strong>Joseph Fletcher (Joe):</strong> Joe is a rising sophomore at Howard University.</li>
        <li><strong> He will be spending his summer in Washington DC and Massachusetts. </li>
          
          
        <li><strong>Customization:</strong> Our goals for The Chat in the Hat is to 
        bring safe and secure messaging between friends. Long distance communication
        is very important, and we hope to address this need! </li>
      </ul>

      <p>
      </p>
    </div>
  </div>
</body>
</html>
