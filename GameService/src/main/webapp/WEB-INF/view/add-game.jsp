<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
    <head>
        <meta charset="utf-8">
        <title>Додайте або оновіть гру</title>
      <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
      <link rel="stylesheet" href="/resources/demos/style.css">
      <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
      <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
     </head>
     <style>
         .checkbox-dropdown {
             width: 250px;
             border: 1px solid #aaa;
             padding: 10px;
             position: relative;
             margin-left:40px;
             user-select: none;
             margin-bottom:40px;
             top:200px;
             display:inline-block;
             background-color:white;
         }

         .checkbox-dropdown:after {
             content:'';
             height: 0;
             position: absolute;
             width: 0;
             border: 6px solid transparent;
             border-top-color: #000;
             top: 50%;
             right: 10px;
             margin-top: -3px;
             background-color:white;
         }

         .checkbox-dropdown.is-active:after {
             border-bottom-color: #000;
             border-top-color: #fff;
             margin-top: -9px;
             background-color:white;
         }

         .checkbox-dropdown-list {
             list-style: none;
             margin: 0;
             padding: 0;
             position: absolute;
             top: 100%;
             border: inherit;
             border-top: none;
             left: -1px;
             right: -1px;
             opacity: 0;

             transition: opacity 0.4s ease-in-out;
             height: 350px;
             overflow: scroll;
             overflow-x: hidden;
             pointer-events: none;
             background-color:white;
             z-index:100;
         }
         .is-active .checkbox-dropdown-list {
             opacity: 1;
             pointer-events: auto;
             background-color:white;
         }

         .checkbox-dropdown-list li label {
             display: block;
             border-bottom: 1px solid silver;
             padding: 10px;
             transition: all 0.2s ease-out;
             background-color:white;
         }

         .checkbox-dropdown-list li label:hover {
             background-color: #555;
             color: white;
         }
         html,body{ height:100%;}
    </style>
    <body style="margin:0px; font-family:verdana;" onload="load()">

        <form:form id="send" style="height:100%;" modelAttribute="game" method="POST">
            <div style="display:flex; width:100%; min-height:100%;">
                <div style="width:50%; background-color:#f0c654; min-height:100%;">
                <h2 style="margin-left:40px; margin-top:20px;">ТУТ ВИ МОЖЕТЕ ДОДАТИ АБО ОНОВИТИ ІНФОРМАЦІЮ ПРО ГРУ</h2>
                <div id="block" style="margin-left:30px;">
                    <div id="nameBlock" style="margin-top:40px;">
                        <label for="tags">Назва гри: </label>
                        <br>
                        <form:input style="width:300px;" id="gameTags" path="name" type="text" required='true' placeholder="Укажіть назву"/>
                    </div>

                    <br>
                    <br>

                    <div id="releaseBlock">
                        <label for="tags">Дата релізу: </label>
                        <br>
                        <form:input id="gDate" type="date" path="releaseDate" required='true' placeholder="Укажіть дату релізу"/>
                    </div>

                    <br>
                    <br>

                    <div class="ui-widget">
                      <label for="tags">Додайте нового видавця, або оберіть з наведених при пошуку: </label>
                      <br>
                      <form:input required='true' id="tags" path="publisher.name"/>
                    </div>

                    <br>
                    <br>

                    <div id="costBlock">
                        <label for="tags">Бюджет гри: </label>
                        <br>
                        <form:input type="text" path="cost" required='true' placeholder="Укажіть бюджет гри"/>
                    </div>

                    <br>
                    <br>

                    <div id="descriptionBlock">
                        <label for="tags">Опис гри: </label>
                        <br>
                        <form:textarea type="text" path="description" required='true' placeholder="Опис гри" style="width:400px; height:100px;"/>
                    </div>

                    <br>
                    <br>
                    <div id="categoryBlock">
                        <label for="tags">Додайте нову категорію, або оберіть зі списку праворуч: </label>
                        <br>
                        <input id="catAdd" type="button" value="Додати нову категорію" onclick="addCat()" />
                    </div>
                    <br>
                    <br>
                    <div id="devBlock">
                        <label for="tags">Додайте нового розробника, або оберіть зі списку праворуч: </label>
                        <br>
                        <input id="devAdd" class="toBlock" type="button" value="Додати нового розробника" onclick="addDev()"/>
                    </div>
                    <br>
                    <br>
                </div>
                    <input id="applyB" style="margin-left:300px; margin-bottom:40px; width:200px; height:40px; background-color:white; font-size:20px;" type="button" value="Підтвердити" onclick="apply()" />
                    <input id="sendB" style="display:none; margin-bottom:40px; margin-left:300px; width:300px; height:60px; background-color:green; font-size:24px; color:white;" type="submit" value="Надіслати"/>
                    <input id="changeB" style="display:none; margin-bottom:40px; margin-left:50px; width:200px; height:30px; background-color:white; font-size:13px;" type="button" value="Внести зміни" onclick="addChange()" />
                    <h3 style="color:red; margin-left:50px;">${param.err}</h3>
                </div>
                <div style="width:50%; background-color:#55aeed; min-height:100%;">
                    <a style="user-select:none; font-size:120px; cursor:pointer; color:#505250; right:0; margin-right:400px; position:absolute; text-decoration: none;" href="http://localhost:9191/games">&larr;</a>

                        <div class="checkbox-dropdown">
                          Оберіть країни
                          <ul class="checkbox-dropdown-list">
                          <c:forEach var="GCountry" items="${allCountries}">
                            <li>
                              <label> <form:checkbox path="countries" value="${GCountry}"/> ${GCountry.name} </label>
                            </li>
                            </c:forEach>
                          </ul>
                        </div>

                        <div class="checkbox-dropdown">
                          Оберіть категорії
                          <ul class="checkbox-dropdown-list">
                          <c:forEach var="GCategory" items="${allCategories}">
                            <li>
                              <label> <form:checkbox path="categories" value="${GCategory}"/> ${GCategory.name} </label>
                            </li>
                            </c:forEach>
                          </ul>
                        </div>

                        <div class="checkbox-dropdown">
                          Оберіть Розробників
                          <ul class="checkbox-dropdown-list">
                          <c:forEach var="GDeveloper" items="${allDevelopers}">
                            <li>
                              <label> <form:checkbox path="developers" value="${GDeveloper}"/> ${GDeveloper.name} </label>
                            </li>
                            </c:forEach>
                          </ul>
                        </div>
                </div>
            </div>
        </form:form>


    </body>
    <script>
           var publArray = new Array();
            <c:forEach items="${allPublishers}" var="publisher">
                var publ = '${publisher.name}';
                publArray.push(publ);
            </c:forEach>

            var gamesArray = new Array();
             <c:forEach items="${allGames}" var="AGame">
                 var name = '${AGame.name}';
                 gamesArray.push(name);
             </c:forEach>

            $(".checkbox-dropdown").click(function () {
                $(this).toggleClass("is-active");
            });

            $(".checkbox-dropdown ul").click(function(e) {
                e.stopPropagation();
            });

          $( function() {
            var availableTags = publArray;
            $( "#tags" ).autocomplete({
              source: availableTags
            });
          } );

          $( function() {
            var availableTags = gamesArray;
            $( "#gameTags" ).autocomplete({
              source: availableTags
            });
          } );

            function load(){
              if(window.location.href=="http://localhost:9001/games/add"){
                  window.location.replace("http://localhost:9191/games/add");
              }
              let nick = getCookie("nick");
              let id = getCookie("user_id");
              let admin = getCookie("admin");
              if (nick =="" || id == "" || admin=="") {
                   window.location.replace("http://localhost:9191/profile");
                   return;
              }
              }

              function getCookie(cname) {
                let name = cname + "=";
                let ca = document.cookie.split(';');
                for(let i = 0; i < ca.length; i++) {
                  let c = ca[i];
                  while (c.charAt(0) == ' ') {
                    c = c.substring(1);
                  }
                  if (c.indexOf(name) == 0) {
                    return c.substring(name.length, c.length);
                  }
                }
                return "";
              }


                function addCat(){
                    var newInput = document.createElement("INPUT");
                    newInput.setAttribute("class","toBlockCats");
                    newInput.setAttribute("type","text");
                    newInput.setAttribute("placeholder","Назва категорії");
                    document.getElementById("categoryBlock").appendChild(document.createElement("br"));
                    document.getElementById("categoryBlock").appendChild(newInput);
                    document.getElementById("categoryBlock").appendChild(document.createElement("br"));
                }

                function addDev(){
                    var newInput = document.createElement("INPUT");
                    newInput.setAttribute("class","toBlockDevs");
                    newInput.setAttribute("type","text");
                    newInput.setAttribute("placeholder","Назва студії розробника");
                    document.getElementById("devBlock").appendChild(document.createElement("br"));
                    document.getElementById("devBlock").appendChild(newInput);
                    document.getElementById("devBlock").appendChild(document.createElement("br"));
                }

                function apply(){
                    document.getElementById("sendB").style.display="inline-block";
                    document.getElementById("changeB").style.display="inline-block";
                    document.getElementById("applyB").style.display="none";
                    document.getElementById("catAdd").disabled=true;
                    document.getElementById("devAdd").disabled=true;

                    const arrCats = document.getElementsByClassName("toBlockCats");
                    var catsLink="";
                    for (let i = 0; i < arrCats.length; i++) {
                      arrCats[i].disabled = true;
                      catsLink = catsLink + arrCats[i].value +";";
                    }

                    const arrDevs = document.getElementsByClassName("toBlockDevs");
                    var devsLink="";
                    for (let i = 0; i < arrDevs.length; i++) {
                      arrDevs[i].disabled = true;
                      devsLink = devsLink + arrDevs[i].value + ";";
                    }

                    document.getElementById("send").setAttribute("action","http://localhost:9191/games/add?devs="+devsLink+"&cats="+catsLink);
                }

                function addChange(){
                    document.getElementById("sendB").style.display="none";
                    document.getElementById("changeB").style.display="none";
                    document.getElementById("applyB").style.display="block";
                    document.getElementById("catAdd").disabled=false;
                    document.getElementById("devAdd").disabled=false;

                    const arrCats = document.getElementsByClassName("toBlockCats");
                    for (let i = 0; i < arrCats.length; i++) {
                      arrCats[i].disabled = false;
                    }

                    const arrDevs = document.getElementsByClassName("toBlockDevs");
                    for (let i = 0; i < arrDevs.length; i++) {
                      arrDevs[i].disabled = false;
                    }

                }

    </script>
</html>











