<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
    <head>
        <meta charset="utf-8">
        <title>Усі фільми</title>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
        <link rel="stylesheet" href="/resources/demos/style.css">
        <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
        <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
        <style>td{padding:15px;}
              .bold{font-weight:bold;display:inline;}
        </style>
    </head>
    <body style="margin:0px; font-family:verdana;" onload="load()">
        <div id="main">
                <div style="display: flex; width:100%; height:100px; background-color:#027a32; text-align:center; position:fixed; top:0px; z-index:1;">
                    <div style="width:60%; margin-top:24px; text-align:center;">
                        <h1 style="display:inline; margin-top:200px; font-size:40px; color:white;">Усі фільми</h1>
                    </div>
                    <div style="text-align:center; width:40%;">
                        <input id="regB"
                               style="width:200px; height:40px; font-size:18px; margin-left:30px; margin-top:30px; cursor:pointer;"
                               type="button" value="Зареєструватися" onclick="registration()"/>
                        <input id="enterB"
                               style="width:200px; height:40px; font-size:18px; margin-left:10px; margin-top:30px; cursor:pointer; "
                               type="button" value="Увійти" onclick="enter()"/>
                        <input id="profile"
                               style="width:200px; height:40px; font-size:16px; margin-left:30px; margin-top:30px; cursor:pointer; display:none;"
                               type="button" value="Профіль - ${cookie["nick"].getValue()}" onclick="getProfile()"/>
                        <input id="addFilmB"
                               style="width:200px; height:40px; font-size:18px; margin-left:10px; margin-top:30px; cursor:pointer; display:none;"
                               type="button" value="Додати фільм" onclick="addFilm()"/>
                        <input id="exitB"
                               style="width:200px; height:40px; font-size:18px; margin-left:10px; margin-top:30px; cursor:pointer; display:none;"
                               type="button" value="Вийти" onclick="exit()"/>
                    </div>
                </div>

            <div>
                <h3 style="margin-left:30px; margin-top:120px; display:inline; font-size:30px;"><a style="text-decoration: none; color:black;" href="http://localhost:9191/profile">&larr;На головну</a></h3>
                <input id="filmsTags" type="text" value="${searched}" style="width:600px; font-size:16px; margin-top:120px;height:30px; margin-left:300px; display:inline" placeholder="пошук фільму по назві">
                <input type="button" style="width:150px; height:30px; margin-top:120px; margin-left:10px; display:inline;cursor:pointer;" value="Пошук" onclick="filtration()">
                <input type="button" style="width:150px; height:30px; margin-top:120px; margin-left:100px; display:inline; background-color:#f76579; cursor:pointer;" value="Відмінити пошук" onclick="window.location.href = 'http://localhost:9191/films'">
                <h3 style="text-align:center;">${mes}</h3>
            </div>


            <c:forEach var="film" items="${allFilms}">
            <div id="${film.id}fullFilm">
                <c:url var="toFilm" value="/films/${film.id}"></c:url>
                <div style="background-color:#a2cef5;">
                <h1 style="text-align:center"><a style="color:#505250;" href="http://localhost:9191/films/${film.id}">${film.name}</a></h1>
                     <table class="bigT"style="margin:auto; max-width:85%; min-width:80%;">
                         <tr>
                             <th>Загальна інформація</th>
                             <th>Оцінки</th>
                             <th>Опис</th>
                             <th style="border-right:0px;"></th>
                         </tr>
                         <tr>

                            <td style:"max-width:300px;">
                                Дата виходу: <p class="bold"><fmt:formatDate value="${film.releaseDate}" pattern="dd.MM.yyyy" /></p>
                                <br>
                                <br>
                                Видавець: <p class="bold">${film.publisher.name}</p>
                                <br>
                                <br>
                                Режисери:
                                <c:forEach var="dir" items="${film.directors}">
                                    <br>
                                   <p class="bold"> ${dir.name}&nbsp${dir.surname}</p>
                                </c:forEach>
                                <br>
                                <br>
                                Актори:
                                <c:forEach var="act" items="${film.actors}">
                                    <br>
                                    <p class="bold">${act.name}&nbsp${act.surname}</p>
                                </c:forEach>
                                <br>
                                <br>
                                Жанри:
                                <c:forEach var="cat" items="${film.categories}">
                                    <br>
                                    <p class="bold">${cat.name}</p>
                                </c:forEach>
                                <br>
                                <br>
                                Тривалість:<p class="bold">${film.length}</p> хвилин
                            </td>

                             <td style="font-weight:bold; text-align:center; max-width:200px;">
                                 Загальна оцінка: ${film.commonMark}/100
                                 <br>
                                 <br>
                                 Ефекти: ${film.effectMark}/100
                                 <br>
                                 <br>
                                 Історія: ${film.storyMark}/100
                                 <br>
                                 <br>
                                 Зйомка: ${film.cameramanMark}/100
                                 <br>
                                 <br>
                                 Актори: ${film.actorsMark}/100
                                 <br>
                                 <br>
                                 Звук: ${film.soundMark}/100
                             </td>

                             <td style="max-width:250px;">
                             ${film.description}
                             </td>

                             <td style="border-right:0px;  border-bottom:0px;"><input style="width:200px; height:40px; font-size:18px; cursor:pointer;"
                                      type="button" value="Оцінити" onclick="window.location.href = '${toFilm}'"/></td>

                              <td style="max-width:100px; min-width:0px;" ><input data-film-id="${film.id}" class="delB" type="button" style="display:none; width:150px; height:30px; background-color:#f76579; cursor:pointer;"
                                                       value="Видалити фільм" onclick="deleteFilm(this)"></td>
                         </tr>
                     </table>
                 </div>
                 <br>
                 <br>
                 <br>
               </div>
            </c:forEach>
        </div>


        <div id="reg" style="display: none;">
            <div style="width:30%; height:590px; background-color:#72249e; position:fixed; right:37%; top:20%; border-radius:40px;">
                <div style="margin-left:520px; margin-top:17px;">
                    <strong style="text-align:right; cursor:pointer; color:grey; font-size:30px;" onclick="closeRegistration()">X</strong>
                </div>
                <div style="margin-left:204px; margin-top:-10px; margin-bottom:27px;">
                    <strong style="display:inline; font-size:23px; color:#80d9ca;">Реєстрація</strong>
                </div>
                    <div style="margin-left:120px">
                    <form:form action="http://localhost:9191/addUser?link=${requestScope['javax.servlet.forward.request_uri']}" method="post" modelAttribute="user">
                        <a style="font-size:12px; color:white;">*лише латинські маленькі літери, максимальна довжена - 30 літер</a>
                        <form:input id="nick" path="nickname" style="margin-bottom:20px; margin-top:5px; width:300px; height:20px; text-align:center;" type="text" placeholder="Вигадайте нікнейм" onkeyup="checkNick()"/>
                        <br>
                        <form:input id="mail" path="email" style="margin-bottom:20px; width:300px; height:20px; text-align:center;" type="text" placeholder="Укажіть пошту" onkeyup="checkMail()"/>
                        <br>
                        <form:input id="passw" path="password" style="margin-bottom:20px; width:300px; height:20px; text-align:center;" type="password" placeholder="Вигадайте пароль" onkeyup="checkPassw()"/>
                        <br>
                        <input id="repPassw" style="margin-bottom:20px; width:300px; height:20px; text-align:center;" type="password" placeholder="Повторіть пароль" onkeyup="checkPassw()"/>
                        <br>
                        <form:input path="description" style="margin-bottom:20px; width:300px; height:20px; height:70px; text-align:center;" type="text" placeholder="Вигадайте опис прифілю"/>
                        <a style="color:#80d9ca;">*необов'язково</a>
                        <a style="font-size:12px; color:white; margin-right:300px;">*кнопка стане активною після коректного заповнення полів</a>
                        <input id="regButton" style="margin-top:10px; width:310px; height:30px; background-color:grey; text-align:center;" type="submit" disabled value="Зареєструватися" />
                        <br>
                        <br>
                        <a style="color:red; margin-right:100px;">${param.error}</a>
                    </form:form>
                </div>
            </div>
        </div>

        <div id="enter" style="display: none;">
            <div style="width:30%; height:350px; background-color:#525e9e; position:fixed; right:37%; top:20%; border-radius:40px;">
                <div style="margin-left:520px; margin-top:17px;">
                    <strong style="text-align:right; cursor:pointer; color:grey; font-size:30px;" onclick="closeEnter()">X</strong>
                </div>
                <div style="margin-left:250px; margin-top:-10px; margin-bottom:27px;">
                    <strong style="display:inline; font-size:23px; color:#80d9ca;">Вхід</strong>
                </div>
                <div style="margin-left:120px">
                    <form:form action="http://localhost:9191/enter?link=${requestScope['javax.servlet.forward.request_uri']}" method="post" modelAttribute="user">
                        <form:input id="authNick" path="nickname" style="margin-bottom:20px; width:300px; height:20px; text-align:center;" type="text" placeholder="Нікнейм або пошта" onkeyup="checkAuthNick()"/>
                        <br>
                        <form:input id="authPass" path="password" style="margin-bottom:20px; width:300px; height:20px; text-align:center;" type="password" placeholder="Ваш пароль" onkeyup="checkAuthPass()"/>
                        <br>
                        <a style="font-size:11px; color:white; margin-right:100px;">*кнопка стане активною після коректного заповнення полів</a>
                        <input id="authButton" style="margin-top:10px; width:310px; height:30px; background-color:grey; text-align:center;" disabled type="submit" value="Увійти"/>
                        <br>
                        <br>
                        <a style="color:red; margin-right:100px;">${param.authError}</a>
                    </form:form>
                </div>
            </div>
        </div>
        <div id="removeAccept" style="display: none;">
            <div style="width:30%; height:200px; background-color:#525e9e; position:fixed; right:37%; top:20%; border-radius:40px;">
                <div style="margin-left:520px; margin-top:17px;">
                    <strong style="text-align:right; cursor:pointer; color:white; font-size:30px;" onclick="closeAccept()">X</strong>
                </div>
                    <strong style="margin-left:80px; font-size:30px; color:#80d9ca;">Підтвердіть видалення</strong>
                    <br>
                    <br>
                <div style="margin-left:120px">
                  <input onclick="acceptRemove()" style="margin-top:10px; cursor:pointer; width:310px; height:30px; text-align:center;" type="button" value="Підтверджую"/>
                </div>
            </div>
        </div>
    </body>
    <script>


        var nickCheck = false;
        var emailCkeck = false;
        var passwCheck = false;
        var isAuthPass = false;
        var isAuthNick = false;
        var filmToDelete;

        var filmsArray = new Array();
         <c:forEach items="${allFilms}" var="AFilm">
             var name = '${AFilm.name}';
             filmsArray.push(name);
         </c:forEach>

        $( function() {
          var availableTags = filmsArray;
          $( "#filmsTags" ).autocomplete({
            source: availableTags
          });
        } );



        function getProfile(){
            window.location.replace("http://localhost:9191/profile/user/${cookie["nick"].getValue()}");

        }
        function addFilm(){
            window.location.replace("http://localhost:9191/films/add");
        }

        function load(){
          if(window.location.href=="http://localhost:9002/films"){
              window.location.replace("http://localhost:9191/films");
          }
          let nick = getCookie("nick");
          let id = getCookie("user_id");
          let admin = getCookie("admin");
          if (nick =="" || id == "") {
               return;
          } else {
            document.getElementById("exitB").style.display = "inline";
            document.getElementById("profile").style.display = "inline";
            document.getElementById("enterB").style.display = "none";
            document.getElementById("regB").style.display = "none";
                if(admin!=""){
                    document.getElementById("addFilmB").style.display = "inline";
                    const delButs = document.getElementsByClassName("delB");
                    for (let i = 0; i < delButs.length; i++) {
                      delButs[i].style.display = "block";
                    }
                }
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

        function checkAuthNick(){
        var nick = document.getElementById("authNick").value;
        if ((nick.trim() != "" && /^[a-z]{0,30}$/.test(nick)) || /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(nick)){
                isAuthNick = true;
                checkAuthorisation();
            }else{
                isAuthNick = false;
                checkAuthorisation();
            }
        }

        function checkAuthPass(){
            if(document.getElementById("authPass").value.trim() != ""){
                isAuthPass = true;
                checkAuthorisation();
            }else{
                isAuthPass = false;
                checkAuthorisation();
            }
        }


        function checkAuthorisation(){
            if(isAuthNick && isAuthPass){
               document.getElementById("authButton").disabled = false;
               document.getElementById("authButton").style = "margin-top:10px; width:310px; height:30px; background-color:#309e24; text-align:center;";
            }else
            {
               document.getElementById("authButton").disabled = true;
               document.getElementById("authButton").style = "margin-top:10px; width:310px; height:30px; background-color:grey; text-align:center;";
            }
        }

       function checkNick()
       {
       var nick = document.getElementById("nick").value;
        if (nick.trim() != "" && /^[a-z]{0,30}$/.test(nick))
           {
                nickCheck = true;
                validationCheck();
           }else{
           nickCheck = false;
           validationCheck();
           }
       }

       function checkMail()
       {
        if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(document.getElementById("mail").value))
            {
                emailCkeck = true;
                validationCheck();
            }else{
            emailCkeck = false;
            validationCheck();
            }
       }


       function checkPassw()
       {
           pass1 = document.getElementById("passw").value;
           pass2 = document.getElementById("repPassw").value;
           if ((pass1.trim() != "" || pass2.trim() != "") && (pass1===pass2))
           {
               passwCheck = true;
               validationCheck();
               return;
           }else{
           passwCheck = false;
           validationCheck();
           }
       }

       function validationCheck()
       {
            if(nickCheck && emailCkeck && passwCheck)
            {
               document.getElementById("regButton").disabled = false;
               document.getElementById("regButton").style = "margin-top:10px; width:310px; height:30px; background-color:#309e24; text-align:center;";
            }else
            {
               document.getElementById("regButton").disabled = true;
               document.getElementById("regButton").style = "margin-top:10px; width:310px; height:30px; background-color:grey; text-align:center;";
            }
       }


       function registration(){
            if(document.getElementById('enter').style.display=="block")
                {
                    document.getElementById('enter').style="display: none;";
                    document.getElementById('main').style="opacity:1";
                }
            if(document.getElementById('reg').style.display=="block")
                {
                    document.getElementById('reg').style="display: none;";
                    document.getElementById('main').style="opacity:1";
                }
            else
                {
                    document.getElementById('reg').style="display: block;";
                    document.getElementById('main').style="opacity:0.75";
                }
        }

       function enter(){
             if(document.getElementById('reg').style.display=="block")
             {
                 document.getElementById('reg').style="display: none;";
                 document.getElementById('main').style="opacity:1";
             }
            if(document.getElementById('enter').style.display=="block")
            {
                document.getElementById('enter').style="display: none;";
                document.getElementById('main').style="opacity:1";
            }
            else
            {
                document.getElementById('enter').style="display: block;";
                document.getElementById('main').style="opacity:0.75";
            }
        }

        function closeEnter(){
            document.getElementById('enter').style="display: none;";
            document.getElementById('main').style="opacity:1";
        }

        function closeRegistration(){
            document.getElementById('reg').style="display: none;";
            document.getElementById('main').style="opacity:1";
        }

       function exit() {
           document.cookie ='user_id=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
           document.cookie ='nick=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
           document.cookie ='admin=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
           window.location.replace(window.location.href);
         }


        function filtration(){
            window.location.replace("http://localhost:9191/films?fname="+$("#filmsTags").val());
         }


         function deleteFilm(film){
            document.getElementById('removeAccept').style="display: block;";
            document.getElementById('main').style="opacity:0.75";
            filmToDelete = film;
         }

         function closeAccept(){
             document.getElementById("removeAccept").style.display="none";
             document.getElementById('main').style="opacity:1";
         }

         function acceptRemove(){
             $.ajax({
                 type: "POST",
                 url: "http://localhost:9191/films/${id}",
                 data: "filmId="+filmToDelete.getAttribute("data-film-id"),
                 success: function(response){
                  if(response=="BAD"){
                      return;
                     }
                  if(response=="OK"){
                      document.getElementById(filmToDelete.getAttribute("data-film-id")+"fullFilm").style.display="none";
                      document.getElementById("removeAccept").style.display="none";
                      document.getElementById('main').style="opacity:1";
                  }
                 },
             });
         }
    </script>
</html>


