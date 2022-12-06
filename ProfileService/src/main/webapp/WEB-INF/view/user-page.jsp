<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    <head>
        <meta charset="utf-8">
        <title>Профіль пана ${name}</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <style>
            th{
                padding:15px;
                border-right:1px solid #505250;
                text-transform: uppercase;
               }
            td{
                padding:15px;
                border-bottom:1px solid #505250;
                border-right:1px solid #505250;
            }

            table {
              border-collapse: collapse;
              margin: 20px;
              padding: 0;
              width:350px;
              margin-left:auto;
              margin-right:auto;
            }

            html,body{ height:100%;}


        </style>
    </head>
    <body id="body" style="margin:0px; font-family:verdana;"onload="load()">
        <div id="main" style="height:100%;">
                <div style="display: flex; width:100%; height:100px; background-color:#027a32; text-align:center; position:fixed; z-index: 1;">
                    <div style="width:65%; margin-top:24px; text-align:center;">
                        <h1 style="display:inline; margin-top:200px; font-size:40px; color:white;">Профіль пана - ${name}</h1>
                    </div>
                    <div style="text-align:center;">
                        <input id="regB"
                               style="width:200px; height:40px; font-size:18px; margin-left:30px; margin-top:30px; cursor:pointer;"
                               type="button" value="Зареєструватися" onclick="registration()"/>
                        <input id="enterB"
                               style="width:200px; height:40px; font-size:18px; margin-left:10px; margin-top:30px; cursor:pointer;"
                               type="button" value="Увійти" onclick="enter()"/>
                        <input id="profile"
                               style="width:200px; height:40px; font-size:16px; margin-left:30px; margin-top:30px; cursor:pointer; display:none;"
                               type="button" value="Профіль - ${cookie["nick"].getValue()}" onclick="getProfile()"/>
                        <input id="settB"
                                style="width:150px; height:40px; font-size:18px; margin-left:10px; margin-top:30px; cursor:pointer; display:none;"
                                type="button" value="Налаштування" onclick="settings()"/>
                        <input id="exitB"
                               style="width:200px; height:40px; font-size:18px; margin-left:10px; margin-top:30px; cursor:pointer; display:none;"
                               type="button" value="Вийти" onclick="exit()"/>
                    </div>
                </div>

            <div style="display: flex; min-height:100%;">
                <div id="gameExpand" style="width:33%; min-height: 100%; background-color:#ff8c8c; text-align:center; z-index: 0;">
                        <h1 style="z-index: 2; margin-top:110px; font-size:50px; cursor:pointer;"><a style="color:#505250; " href="http://localhost:9191/games">ІГРИ</a></h1>
                        <span id="gArrow" style="z-index: 2; font-size:100px; cursor:pointer; color:#505250;"onclick="expandG()">&rarr;</span>
                        <c:forEach var="review" items="${reviews.games}">
                                <c:url var="toReview" value="/profile/user/${name}/game/${review.id}"></c:url>
                                <h1><a style="color:#505250; " href="http://localhost:9191/games/${review.game.id}">${review.game.name}</a></h1>
                                 <div class="fullT" id="fullT" style="display:none;">
                                     <table class="bigT">
                                         <tr>
                                             <th>Загальна оцінка</th>
                                             <th>Ефекти</th>
                                             <th>Історія</th>
                                             <th>Геймплей</th>
                                             <th>Ідея</th>
                                             <th>Звук</th>
                                             <th>Витрачений час</th>
                                             <th style="border-right:0px;"></th>

                                         </tr>
                                         <tr>
                                             <td style="font-weight:bold;">${review.commonMark}/100</td>
                                             <td>${review.effectMark}/100</td>
                                             <td>${review.storyMark}/100</td>
                                             <td>${review.gameplayMark}/100</td>
                                             <td>${review.ideaMark}/100</td>
                                             <td>${review.soundMark}/100</td>
                                             <td>${review.spentTime} годин</td>
                                             <td style="border-right:0px;  border-bottom:0px;"><input id="toReviewGame"
                                                      style="width:200px; height:40px; font-size:18px; cursor:pointer;"
                                                      type="button" value="Повна рецензія" onclick="window.location.href = '${toReview}'"/></td>
                                         </tr>

                                     </table>
                                 </div>

                                 <div class="smallT" id="smallT" style="display:block;">
                                     <table>
                                         <tr>
                                             <td style="font-weight:bold;">Загальна оцінка</td>
                                             <td style="font-weight:bold;">${review.commonMark}/100</td>
                                         </tr>
                                         <tr>
                                             <td>Ефекти</td>
                                             <td>${review.effectMark}/100</td>
                                         </tr>
                                         <tr>
                                             <td>Історія</td>
                                             <td>${review.storyMark}/100</td>
                                         </tr>

                                         <tr>
                                             <td>Геймплей</td>
                                             <td>${review.gameplayMark}/100</td>
                                         </tr>

                                         <tr>
                                             <td>Ідея</td>
                                             <td>${review.ideaMark}/100</td>
                                         </tr>
                                         <tr>
                                             <td>Звук</td>
                                             <td>${review.soundMark}/100</td>
                                         </tr>
                                         <tr>
                                             <td>Витрачений час</td>
                                             <td>${review.spentTime} годин</td>
                                         </tr>
                                     </table>
                                     <input id="toReviewGame"
                                                    style="width:200px; height:40px; font-size:18px; cursor:pointer;margin-top:15px; margin-bottom:35px;"
                                                    type="button" value="Повна рецензія" onclick="window.location.href = '${toReview}'"/>
                                 </div>
                        </c:forEach>
                </div>





                <div id="filmExpand" style="width:33%; min-height: 100%; background-color:#b8b6fc; text-align:center; z-index: 0;">
                    <h1 style="z-index: 2; margin-top:110px; font-size:50px; cursor:pointer;"><a style="color:#505250;" href="http://localhost:9191/films">ФІЛЬМИ</a></h1>
                    <span id="fArrow" style="z-index: 2; font-size:100px; cursor:pointer; color:#505250;" onclick="expandF()">&larr;&rarr;</span>
                     <c:forEach var="review" items="${reviews.films}">
                         <c:url var="toFilmReview" value="/profile/user/${name}/film/${review.id}"></c:url>
                         <h1><a style="color:#505250; " href="http://localhost:9191/films/${review.film.id}">${review.film.name}</a></h1>
                         <div class="fullFT" id="fullFT" style="display:none;">
                             <table class="bigFT">
                                 <tr>
                                     <th>Загальна оцінка</th>
                                     <th>Ефекти</th>
                                     <th>Історія</th>
                                     <th>Звук</th>
                                     <th>Операторська робота</th>
                                     <th>Актори</th>
                                     <th style="border-right:0px;"></th>

                                 </tr>
                                 <tr>
                                     <td style="font-weight:bold;">${review.commonMark}/100</td>
                                     <td>${review.effectMark}/100</td>
                                     <td>${review.storyMark}/100</td>
                                     <td>${review.soundMark}/100</td>
                                     <td>${review.cameramanMark}/100</td>
                                     <td>${review.actorsMark}/100</td>
                                     <td style="border-right:0px;  border-bottom:0px;"><input id="toReviewFilm"
                                              style="width:200px; height:40px; font-size:18px; cursor:pointer;"
                                              type="button" value="Повна рецензія" onclick="window.location.href = '${toFilmReview}'"/></td>
                                 </tr>

                             </table>
                         </div>
                             <div class="smallFT" id="smallFT" style="display:block;">
                                 <table>
                                     <tr>
                                         <td style="font-weight:bold;">Загальна оцінка</td>
                                         <td style="font-weight:bold;">${review.commonMark}/100</td>
                                     </tr>
                                     <tr>
                                         <td>Ефекти</td>
                                         <td>${review.effectMark}/100</td>
                                     </tr>
                                     <tr>
                                         <td>Історія</td>
                                         <td>${review.storyMark}/100</td>
                                     </tr>

                                     <tr>
                                         <td>Звук</td>
                                         <td>${review.soundMark}/100</td>
                                     </tr>

                                     <tr>
                                         <td>Операторська робота</td>
                                         <td>${review.cameramanMark}/100</td>
                                     </tr>
                                     <tr>
                                         <td>Актори</td>
                                         <td>${review.actorsMark}/100</td>
                                     </tr>
                                 </table>
                                 <input id="toFilmReview"
                                                style="width:200px; height:40px; font-size:18px; cursor:pointer;margin-top:15px; margin-bottom:35px;"
                                                type="button" value="Повна рецензія" onclick="window.location.href = '${toFilmReview}'"/>
                             </div>
                      </c:forEach>
                </div>


                <div id="bookExpand" style="width:35%; min-height: 100%; background-color:#b4fab4; text-align:center; z-index: 0;">
                    <h1 style="z-index: 2; margin-top:110px; font-size:50px; cursor:pointer;"><a style="color:#505250;" href="http://localhost:9191/books">КНИГИ</a></h1>
                    <span id="bArrow" style="z-index: 2; font-size:100px; cursor:pointer; color:#505250;" onclick="expandB()">&larr;</span>
                    <c:forEach var="review" items="${reviews.books}">
                        <c:url var="toBookReview" value="/profile/user/${name}/book/${review.id}"></c:url>
                        <h1><a style="color:#505250; " href="http://localhost:9191/books/${review.book.id}">${review.book.name}</a></h1>
                        <div class="fullBT" id="fullBT" style="display:none;">
                            <table class="bigBT">
                                <tr>
                                    <th>Загальна оцінка</th>
                                    <th>Текст</th>
                                    <th>Історія</th>
                                    <th style="border-right:0px;"></th>
                                </tr>
                                <tr>
                                    <td style="font-weight:bold;">${review.commonMark}/100</td>
                                    <td>${review.artMark}/100</td>
                                    <td>${review.storyMark}/100</td>
                                    <td style="border-right:0px;  border-bottom:0px;"><input id="toReviewBook"
                                             style="width:200px; height:40px; font-size:18px; cursor:pointer;"
                                             type="button" value="Повна рецензія" onclick="window.location.href = '${toBookReview}'"/></td>
                                </tr>
                            </table>
                        </div>
                            <div class="smallBT" id="smallBT" style="display:block;">
                                <table>
                                    <tr>
                                        <td style="font-weight:bold;">Загальна оцінка</td>
                                        <td style="font-weight:bold;">${review.commonMark}/100</td>
                                    </tr>
                                    <tr>
                                        <td>Текст</td>
                                        <td>${review.artMark}/100</td>
                                    </tr>
                                    <tr>
                                        <td>Історія</td>
                                        <td>${review.storyMark}/100</td>
                                    </tr>
                                </table>
                                <input id="toBookReview"
                                               style="width:200px; height:40px; font-size:18px; cursor:pointer;margin-top:15px; margin-bottom:35px;"
                                               type="button" value="Повна рецензія" onclick="window.location.href = '${toBookReview}'"/>
                            </div>
                     </c:forEach>

                </div>

            </div>
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


    </body>
    <script>

        var nickCheck = false;
        var emailCkeck = false;
        var passwCheck = false;
        var isAuthPass = false;
        var isAuthNick = false;

    function exit() {
        document.cookie ='user_id=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
        document.cookie ='nick=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
        document.cookie ='admin=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
        window.location.replace(window.location.href);
      }

      function expandG(){
          if(document.getElementById("gameExpand").style.width != "100%"){
                document.getElementById("gameExpand").style.width="100%";
                document.getElementById("body").style="margin:0px; font-family:verdana; user-select: none; background-color:#ff8c8c;";
                document.getElementById("filmExpand").style.display="none";
                document.getElementById("bookExpand").style.display="none";
                document.getElementById("gArrow").innerHTML = "&larr;";
                document.getElementById("gArrow").style = "z-index: 2; font-size:100px; cursor:pointer; color:#505250; position:absolute; margin-left:640px; position:fixed;";
                const smTable = document.getElementsByClassName("smallT");
                for (let i = 0; i < smTable.length; i++) {
                  smTable[i].style.display="none";
                }
                const fTable = document.getElementsByClassName("fullT");
                for (let i = 0; i < fTable.length; i++) {
                  fTable[i].style="display:block; margin-bottom:80px;";
                  document.getElementsByClassName("bigT")[i].style="width:60%; margin-left:auto;margin-right:auto;";
                }

            }else{
                document.getElementById("gameExpand").style.width="33%";
                document.getElementById("filmExpand").style.display="block";
                document.getElementById("bookExpand").style.display="block";
                document.getElementById("gArrow").innerHTML = "&rarr;";
                document.getElementById("gArrow").style = "z-index: 2; font-size:100px; cursor:pointer; color:#505250;";
                const smTable = document.getElementsByClassName("smallT");
                for (let i = 0; i < smTable.length; i++) {
                  smTable[i].style.display="block";
                }
                const fTable = document.getElementsByClassName("fullT");
                for (let i = 0; i < fTable.length; i++) {
                  fTable[i].style.display="none";
                }
            }
        }
     function expandF(){
         if(document.getElementById("filmExpand").style.width != "100%"){
               document.getElementById("body").style="margin:0px; font-family:verdana; user-select: none; background-color:#b8b6fc;";
               document.getElementById("gameExpand").style.display="none"
               document.getElementById("filmExpand").style.width="100%"
               document.getElementById("bookExpand").style.display="none"
               document.getElementById("fArrow").innerHTML = "&rarr;&larr;";
               document.getElementById("fArrow").style = "z-index: 2; font-size:100px; cursor:pointer; color:#505250; position:absolute; margin-left:640px; position:fixed;";
               const smTable = document.getElementsByClassName("smallFT");
               for (let i = 0; i < smTable.length; i++) {
                 smTable[i].style.display="none";
               }
               const fTable = document.getElementsByClassName("fullFT");
               for (let i = 0; i < fTable.length; i++) {
                 fTable[i].style="display:block; margin-bottom:80px;";
                 document.getElementsByClassName("bigFT")[i].style="width:60%; margin-left:auto;margin-right:auto;";
               }


           }else{
               document.getElementById("gameExpand").style.display="block"
               document.getElementById("filmExpand").style.width="33%"
               document.getElementById("bookExpand").style.display="block"
               document.getElementById("fArrow").innerHTML = "&larr;&rarr;";
               document.getElementById("fArrow").style = "z-index: 2; font-size:100px; cursor:pointer; color:#505250;";
               const smTable = document.getElementsByClassName("smallFT");
               for (let i = 0; i < smTable.length; i++) {
                 smTable[i].style.display="block";
               }
               const fTable = document.getElementsByClassName("fullFT");
               for (let i = 0; i < fTable.length; i++) {
                 fTable[i].style.display="none";
               }
           }
       }



      function expandB(){
          if(document.getElementById("bookExpand").style.width != "100%"){
                document.getElementById("body").style="margin:0px; font-family:verdana; user-select: none; background-color:#b4fab4;";
                document.getElementById("gameExpand").style.display="none"
                document.getElementById("filmExpand").style.display="none"
                document.getElementById("bookExpand").style.width="100%"
                document.getElementById("bArrow").innerHTML = "&rarr;";
                document.getElementById("bArrow").style = "z-index: 2; font-size:100px; cursor:pointer; color:#505250; position:absolute; margin-left:640px; position:fixed;";
                const smTable = document.getElementsByClassName("smallBT");
                for (let i = 0; i < smTable.length; i++) {
                  smTable[i].style.display="none";
                }
                const fTable = document.getElementsByClassName("fullBT");
                for (let i = 0; i < fTable.length; i++) {
                  fTable[i].style="display:block; margin-bottom:80px;";
                  document.getElementsByClassName("bigBT")[i].style="width:60%; margin-left:auto;margin-right:auto;";
                }

            }else{
                document.getElementById("gameExpand").style.display="block"
                document.getElementById("filmExpand").style.display="block"
                document.getElementById("bookExpand").style.width="35%"
                document.getElementById("bArrow").innerHTML = "&larr;";
                document.getElementById("bArrow").style = "z-index: 2; font-size:100px; cursor:pointer; color:#505250;";
                const smTable = document.getElementsByClassName("smallBT");
                for (let i = 0; i < smTable.length; i++) {
                  smTable[i].style.display="block";
                }
                const fTable = document.getElementsByClassName("fullBT");
                for (let i = 0; i < fTable.length; i++) {
                  fTable[i].style.display="none";
                }
            }
        }

        function getProfile(){
            window.location.replace("http://localhost:9191/profile/user/${cookie["nick"].getValue()}");

        }


        function load(){
            if(window.location.href=="http://localhost:9003/profile/user/${name}"){
                window.location.replace("http://localhost:9191/profile/user/${name}");
            }
          let nick = getCookie("nick");
          let id = getCookie("user_id");
          if (nick =="" || id == "") {
               return;
          } else {
            document.getElementById("exitB").style.display = "inline";
            document.getElementById("profile").style.display = "inline";
            document.getElementById("settB").style.display = "inline";
            document.getElementById("enterB").style.display = "none";
            document.getElementById("regB").style.display = "none";
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
                    document.getElementById('main').style="opacity:1;height:100%;";
                }
            if(document.getElementById('reg').style.display=="block")
                {
                    document.getElementById('reg').style="display: none;";
                    document.getElementById('main').style="opacity:1;height:100%;";
                }
            else
                {
                    document.getElementById('reg').style="display: block;";
                    document.getElementById('main').style="opacity:0.75;height:100%;";
                }
        }

       function enter(){
             if(document.getElementById('reg').style.display=="block")
             {
                 document.getElementById('reg').style="display: none;";
                 document.getElementById('main').style="opacity:1; height:100%;";
             }
            if(document.getElementById('enter').style.display=="block")
            {
                document.getElementById('enter').style="display: none;";
                document.getElementById('main').style="opacity:1;height:100%;";
            }
            else
            {
                document.getElementById('enter').style="display: block;";
                document.getElementById('main').style="opacity:0.75;height:100%;";
            }
        }

        function closeEnter(){
            document.getElementById('enter').style="display: none;";
            document.getElementById('main').style="opacity:1;height:100%;";
        }

        function closeRegistration(){
            document.getElementById('reg').style="display: none;";
            document.getElementById('main').style="opacity:1;height:100%;";
        }

        function settings(){
            window.location.replace("http://localhost:9191/profile/user/${name}/settings");
        }

    </script>
</html>