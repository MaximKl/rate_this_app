<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
    <head>
        <meta charset="utf-8">
        <title>Додайте або оновіть фільм</title>
      <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
      <link rel="stylesheet" href="/resources/demos/style.css">
      <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
      <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
     </head>
     <style>
         .checkbox-dropdown {
             width: 300px;
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

        <form:form id="send" style="height:100%;" modelAttribute="film" method="POST">
            <div style="display:flex; width:100%; min-height:100%;">
                <div style="width:50%; background-color:#f0c654; min-height:100%;">
                    <h2 style="margin-left:40px; margin-top:20px;">ТУТ ВИ МОЖЕТЕ ДОДАТИ АБО ОНОВИТИ ІНФОРМАЦІЮ ПРО ФІЛЬМ</h2>
                    <div id="block" style="margin-left:30px;">
                        <div id="nameBlock" style="margin-top:40px;">
                            <label for="tags">Назва фільму: </label>
                            <br>
                            <form:input style="width:300px;" id="filmTags" path="name" type="text" required='true' placeholder="Укажіть назву"/>
                        </div>

                        <br>
                        <br>

                        <div id="releaseBlock">
                            <label for="tags">Дата релізу: </label>
                            <br>
                            <form:input id="fDate" type="date" path="releaseDate" required='true' placeholder="Укажіть дату виходу"/>
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

                        <div class="ui-widget" id="studioBlock">
                            <label for="tags">Додайте нову студію, або оберіть з наведених при пошуку: </label>
                            <br>
                            <form:input required='true' id="studioTags" path="studio.name"/>
                        </div>

                        <br>
                        <br>

                        <div id="costBlock">
                            <label for="tags">Бюджет фільму: </label>
                            <br>
                            <form:input type="text" path="cost" required='true' placeholder="Укажіть бюджет фільму"/>
                        </div>

                        <br>
                        <br>

                        <div id="lengthBlock">
                            <label for="tags">Тривалість фільму (у хвилинах): </label>
                            <br>
                            <form:input type="text" path="length" required='true' placeholder="Укажіть тривалість фільму у хвилинах"/>
                        </div>

                        <br>
                        <br>

                        <div id="descriptionBlock">
                            <label for="tags">Опис фільму: </label>
                            <br>
                            <form:textarea type="text" path="description" required='true' placeholder="Опис фільму" style="width:400px; height:100px;"/>
                        </div>

                        <br>
                        <br>

                        <div id="categoryBlock">
                            <label for="tags">Додайте новий жанр, або оберіть зі списку праворуч: </label>
                            <br>
                            <input id="catAdd" type="button" value="Додати новий жанр" onclick="addCat()" />
                        </div>
                        <br>
                        <br>
                        <div id="actorBlock">
                            <label for="tags">Додайте нового актора, або оберіть зі списку праворуч: </label>
                            <br>
                            <input id="actorAdd" class="toBlock" type="button" value="Додати нового актора" onclick="addActor()"/>
                        </div>
                        <br>
                        <br>
                        <div id="directorBlock">
                            <label for="tags">Додайте нового режисера, або оберіть зі списку праворуч: </label>
                            <br>
                            <input id="directorAdd" class="toBlock" type="button" value="Додати нового режисера" onclick="addDirector()"
                        </div>
                        <br>
                        <br>
                    </div>
                    <input id="applyB" style="margin-left:300px; margin-bottom:40px; margin-top:40px; width:200px; height:40px; background-color:white; font-size:20px;" type="button" value="Підтвердити" onclick="apply()" />
                    <input id="sendB" style="display:none; margin-bottom:40px; margin-left:300px; width:300px; margin-top:40px; height:60px; background-color:green; font-size:24px; color:white;" type="submit" value="Надіслати"/>
                    <input id="changeB" style="display:none; margin-bottom:40px; margin-left:50px; margin-top:40px; width:200px; height:30px; background-color:white; font-size:13px;" type="button" value="Внести зміни" onclick="addChange()" />
                    <h3 style="color:red; margin-left:50px;">${param.err}</h3>
                </div>
                </div>
                <div style="width:50%; background-color:#55aeed; min-height:100%;">
                    <a style="user-select:none; font-size:120px; cursor:pointer; color:#505250; right:0; margin-right:400px; position:absolute; text-decoration: none;" href="http://localhost:9191/films">&larr;</a>

                        <div class="checkbox-dropdown">
                          Оберіть країни
                          <ul class="checkbox-dropdown-list">
                          <c:forEach var="FCountry" items="${allCountries}">
                            <li>
                              <label> <form:checkbox path="countries" value="${FCountry}"/> ${FCountry.name} </label>
                            </li>
                            </c:forEach>
                          </ul>
                        </div>

                        <div class="checkbox-dropdown">
                          Оберіть категорії
                          <ul class="checkbox-dropdown-list">
                          <c:forEach var="FCategory" items="${allCategories}">
                            <li>
                              <label> <form:checkbox path="categories" value="${FCategory}"/> ${FCategory.name} </label>
                            </li>
                            </c:forEach>
                          </ul>
                        </div>

                        <div class="checkbox-dropdown">
                          Оберіть акторів
                          <ul class="checkbox-dropdown-list">
                          <c:forEach var="FActor" items="${allActors}">
                            <li>
                              <label> <form:checkbox path="actors" value="${FActor}"/>${FActor.name}&nbsp${FActor.surname}</label>
                            </li>
                            </c:forEach>
                          </ul>
                        </div>

                        <div class="checkbox-dropdown">
                          Оберіть режисерів
                          <ul class="checkbox-dropdown-list">
                          <c:forEach var="FDirector" items="${allDirectors}">
                            <li>
                              <label> <form:checkbox path="directors" value="${FDirector}"/>${FDirector.name}&nbsp${FDirector.surname}</label>
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


            var filmsArray = new Array();
             <c:forEach items="${allFilms}" var="AFilm">
                 var filmName = '${AFilm.name}';
                 filmsArray.push(filmName);
             </c:forEach>

             var studioArray = new Array();
              <c:forEach items="${allStudios}" var="AStudio">
                  var stName = '${AStudio.name}';
                  studioArray.push(stName);
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
            var availableTags = filmsArray;
            $( "#filmTags" ).autocomplete({
              source: availableTags
            });
          } );

          $( function() {
            var availableTags = studioArray;
            $( "#studioTags" ).autocomplete({
              source: availableTags
            });
          } );

            function load(){
              if(window.location.href=="http://localhost:9002/films/add"){
                  window.location.replace("http://localhost:9191/films/add");
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
                    newInput.setAttribute("placeholder","Назва жанру");
                    document.getElementById("categoryBlock").appendChild(document.createElement("br"));
                    document.getElementById("categoryBlock").appendChild(newInput);
                    document.getElementById("categoryBlock").appendChild(document.createElement("br"));
                }

                function addActor(){
                    var newInput = document.createElement("INPUT");
                    newInput.setAttribute("class","toBlockActors");
                    newInput.setAttribute("type","text");
                    newInput.setAttribute("placeholder","Спочатку ім'я, потім прізвище актора");
                    newInput.setAttribute("style","width:300px;");
                    document.getElementById("actorBlock").appendChild(document.createElement("br"));
                    document.getElementById("actorBlock").appendChild(newInput);
                    document.getElementById("actorBlock").appendChild(document.createElement("br"));
                }

                function addDirector(){
                    var newInput = document.createElement("INPUT");
                    newInput.setAttribute("class","toBlockDirectors");
                    newInput.setAttribute("type","text");
                    newInput.setAttribute("placeholder","Спочатку ім'я, потім прізвище режисера");
                    newInput.setAttribute("style","width:300px;");
                    document.getElementById("directorBlock").appendChild(document.createElement("br"));
                    document.getElementById("directorBlock").appendChild(newInput);
                    document.getElementById("directorBlock").appendChild(document.createElement("br"));
                }

                function apply(){
                    document.getElementById("sendB").style.display="inline-block";
                    document.getElementById("changeB").style.display="inline-block";
                    document.getElementById("applyB").style.display="none";
                    document.getElementById("catAdd").disabled=true;
                    document.getElementById("actorAdd").disabled=true;
                    document.getElementById("directorAdd").disabled=true;

                    const arrCats = document.getElementsByClassName("toBlockCats");
                    var catsLink="";
                    for (let i = 0; i < arrCats.length; i++) {
                      arrCats[i].disabled = true;
                      catsLink = catsLink + arrCats[i].value +";";
                    }

                    const arrActors = document.getElementsByClassName("toBlockActors");
                    var actorsLink="";
                    for (let i = 0; i < arrActors.length; i++) {
                      arrActors[i].disabled = true;
                      actorsLink = actorsLink + arrActors[i].value + ";";
                    }

                    const arrDirectors = document.getElementsByClassName("toBlockDirectors");
                    var directorsLink="";
                    for (let i = 0; i < arrDirectors.length; i++) {
                      arrDirectors[i].disabled = true;
                      directorsLink = directorsLink + arrDirectors[i].value + ";";
                    }
                    document.getElementById("send").setAttribute("action","http://localhost:9191/films/add?acts="+actorsLink+"&cats="+catsLink+"&dirs="+directorsLink);
                }

                function addChange(){
                    document.getElementById("sendB").style.display="none";
                    document.getElementById("changeB").style.display="none";
                    document.getElementById("applyB").style.display="block";
                    document.getElementById("catAdd").disabled=false;
                    document.getElementById("actorAdd").disabled=false;
                    document.getElementById("directorAdd").disabled=false;

                    const arrCats = document.getElementsByClassName("toBlockCats");
                    for (let i = 0; i < arrCats.length; i++) {
                      arrCats[i].disabled = false;
                    }

                    const arrActors = document.getElementsByClassName("toBlockActors");
                    for (let i = 0; i < arrActors.length; i++) {
                      arrActors[i].disabled = false;
                    }

                    const arrDirectors = document.getElementsByClassName("toBlockDirectors");
                    for (let i = 0; i < arrDirectors.length; i++) {
                      arrDirectors[i].disabled = false;
                    }
                }

    </script>
</html>











