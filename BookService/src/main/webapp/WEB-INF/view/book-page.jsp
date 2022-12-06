<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
    <head>
        <meta charset="utf-8">
        <title>Сторінка книги - ${book.name}</title>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
        <link rel="stylesheet" href="/resources/demos/style.css">
        <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
        <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    </head>
    <style>
        td{padding-top:45px;padding-bottom:5px; font-size:20px;}
        tr{border-bottom:2px solid #505250;}
        table{margin:auto; border-collapse: collapse; width:80%;}
        html,body{ height:100%; background-color:#5c5e5e;}
        .gInfo{
            font-weight:bold;
            text-align: left;
        }
        .names{
            text-align:left;
        }
    </style>
    <body style="margin:0px; font-family:verdana;" onload="load()">
        <div id="main">
                <div style="display: flex; width:100%; height:100px; background-color:#027a32; text-align:center; position:fixed; top:0px; z-index:1;">
                    <div style="width:60%; margin-top:24px; text-align:center;">
                        <h1 style="display:inline; margin-top:200px; font-size:40px; color:white;">Сторінка книги - ${book.name}</h1>
                    </div>
                    <div style="text-align:center; width:40%;">
                        <input id="regB"
                               style="width:200px; height:40px; font-size:18px; margin-left:30px; margin-top:30px; cursor:pointer;"
                               type="button" value="Зареєструватися" onclick="registration()"/>
                        <input id="enterB"
                               style="width:200px; height:40px; font-size:18px; margin-left:10px; margin-top:30px; cursor:pointer;"
                               type="button" value="Увійти" onclick="enter()"/>
                        <input id="profile"
                               style="width:200px; height:40px; font-size:16px; margin-left:30px; margin-top:30px; cursor:pointer; display:none;"
                               type="button" value="Профіль - ${cookie["nick"].getValue()}" onclick="getProfile()"/>
                        <input id="exitB"
                               style="width:200px; height:40px; font-size:18px; margin-left:10px; margin-top:30px; cursor:pointer; display:none;"
                               type="button" value="Вийти" onclick="exit()"/>
                    </div>
                </div>

            <a style="user-select:none; font-size:120px; cursor:pointer; color:#505250; left:0; top:0; margin-left:100px; margin-top:80px; position:absolute; text-decoration: none;" href="http://localhost:9191/books">&larr;</a>

            <div style="display:flex; width:100%; height:100%;">
                <div style="width:40%; margin-left:50px;">
                    <div style="margin-top:120px; padding-top:20px; background-color:#f7cc54; border-radius:30px;">
                        <h3 style="text-align:center;">Інформація про книгу</h3>
                        <table>
                            <tr>
                                <td class="names">Назва:</td>
                                <td class="gInfo">${book.name}</td>
                            </tr>
                            <tr>
                                <td class="names">Дата публікації:</td>
                                <td class="gInfo"> <fmt:formatDate value="${book.releaseDate}" pattern="dd.MM.yyyy" /></td>
                            </tr>
                            <tr>
                                <td class="names">Автори:</td>
                                <td class="gInfo">
                                <c:forEach var="authors" items="${book.authors}">
                                    ${authors.name}&nbsp${authors.surname},&nbsp;
                                </c:forEach>
                                </td>
                            </tr>

                            <tr>
                                <td class="names">Розмір:</td>
                                <td class="gInfo">${book.size} сторінок</td>
                            </tr>
                            <tr>
                                <td class="names">Країна створення:</td>
                                 <td class="gInfo">
                                <c:forEach var="country" items="${book.countries}">
                                    ${country.name},&nbsp;
                                </c:forEach>
                                </td>
                            </tr>
                            <tr>
                                <td class="names">Категорії:</td>
                                <td class="gInfo">
                                <c:forEach var="category" items="${book.categories}">
                                    ${category.name},&nbsp;
                                </c:forEach>
                                </td>
                            </tr>
                            <tr>
                                <td class="names">Опис:</td>
                                <td class="gInfo">${book.description}</td>
                            </tr>
                        </table>
                        <br>
                    </div>
                </div>
                <div style="width:5%;"></div>
                <div style="width:50%;">
                     <div id="scores" style="margin-top:120px; margin-right:50px; background-color:#5c97f7; border-radius:30px; display:none;">
                        <h3 style="text-align:center; padding-top:30px; margin-top:20px;">Поставте ваші оцінки!</h3>
                        <h4 style="text-align:center; color:#2b1515;">${wrong}</h4>
                        <table>

                            <tr>
                                <td class="names" style="font-weight:bold;">Загальна оцінка:</td>
                                <td style="font-weight:bold;">
                                <select style="width:190px; height:30px; text-align:center;" id="comMark">
                                  <c:forEach var="n" items="${numbers}">
                                      <option value="${n}">${n}</option>
                                  </c:forEach>
                                  <option value="-1" selected label="--не обрано--"></option>
                                </select>
                                </td>
                            </tr>

                            <tr>
                                <td class="names" style="font-weight:bold;">Історія:</td>
                                <td style="font-weight:bold;">
                                <select style="width:190px; height:30px; text-align:center;" id="storyMark">
                                  <c:forEach var="n" items="${numbers}">
                                      <option value="${n}">${n}</option>
                                  </c:forEach>
                                  <option value="-1" selected label="--не обрано--"></option>
                                </select>
                                </td>
                            </tr>

                            <tr>
                                <td class="names" style="font-weight:bold;">Текст:</td>
                                <td style="font-weight:bold;">
                                <select style="width:190px; height:30px; text-align:center;" id="textMark">
                                  <c:forEach var="n" items="${numbers}">
                                      <option value="${n}">${n}</option>
                                  </c:forEach>
                                  <option value="-1" selected label="--не обрано--"></option>
                                </select>
                                </td>
                            </tr>

                        </table>
                        <br>
                        <br>
                        <input id="addScoreB"
                            style="width:200px; height:40px; font-size:18px; margin-left:330px; cursor:pointer;"
                            type="submit" value="ОЦІНИТИ!" onclick="addScore()"/>
                        <br>
                        <br>
                      </div>

                      <div id="regMessage" style="margin-top:120px; margin-right:50px; background-color:#5c97f7; border-radius:30px; display:none;">
                        <h2 style="text-align:center; padding:15px;">ЩОБ ОЦІНИТИ КНИГУ, ПОТРІБНО ЗАРЕЄСТРУВАТИСЯ АБО УВІЙТИ!</h2>
                        <input id="regB"
                               style="width:200px; height:40px; font-size:18px; margin-left:200px; margin-top:30px; cursor:pointer;"
                               type="button" value="Зареєструватися" onclick="registration()"/>
                        <input id="enterB"
                               style="width:200px; height:40px; font-size:18px; margin-left:10px; margin-top:30px; cursor:pointer;"
                               type="button" value="Увійти" onclick="enter()"/>
                               <br>
                               <br>
                      </div>
                      <div id="alreadyMessage" style="margin-top:120px; margin-right:50px; background-color:#5c97f7; border-radius:30px; display:none;" >
                        <h2 style="text-align:center; padding:15px;">ВИ ВЖЕ ОЦІНИЛИ ЦЮ КНИГУ!</h2>
                        <h4 style="text-align:center; color:#2b1515; ">${wrong}</h4>
                        <input id="changeB"
                               style="width:200px; height:40px; font-size:18px; margin-left:400px; margin-top:30px; cursor:pointer;"
                               type="button" value="Змінити оцінки" onclick="changeMarks()"/>
                               <br>
                               <br>
                      </div>

                    <div style="margin-top:30px; margin-right:50px; background-color:#4ff7ba; border-radius:30px;">
                        <h3 style="text-align:center; padding-top:30px; margin-top:20px;">Загально-середні оцінки на сайті</h3>
                            <table>
                                <tr>
                                    <td class="names" style="font-weight:bold;">Загальна оцінка:</td>
                                    <td style="font-weight:bold;">${book.commonMark}/100</td>
                                </tr>
                                <tr>
                                    <td class="names">Історія:</td>
                                    <td>${book.storyMark}/100</td>
                                </tr>
                                <tr>
                                    <td class="names">Тект:</td>
                                    <td>${book.artMark}/100</td>
                                </tr>
                            </table>
                           <br>
                           <br>
                    </div>
                </div>
            </div>
            <br>
            <br>
                <div style="margin-top:40px;">
                    <div id="forComment" style="display:none;">
                        <h2 style="text-align:center; padding:30px; margin-top:20px; color:white; font-size:50px;">Коментарі</h2>
                        <textarea id="comment" type="text" placeholder="Ваш коментар"  style="width:550px; margin-left:650px; font-size:16px; height:100px;"></textarea>
                        <div style="position:absolute; right:0; margin-right:470px; margin-top: -76px;">
                            <input id="commentB" style="width:200px; height:40px; font-size:18px; cursor:pointer; padding-top:-40px;" type="button" value="Надіслати" onclick="sendComment();"/>
                        </div>
                        <h3 id="sendResponse" style="text-align:center; margin-top:40px; color:white;"></h3>
                    </div>
                    <div id="userComs" style="margin-top:40px; display:none;">
                        <h2 style="padding:30px; text-align:center; margin-top:20px; background-color:#5c97f7;">Ваші коментарі</h2>
                        <c:forEach var="coms1" items="${thisBookComment}">
                            <div id="${coms1.id}myFullCom" style="margin:auto; background-color:#5c97f7; text-align:center; max-width:800px; border-radius:30px; margin-top:30px;">
                                     <br>
                                     <p>${coms1.body}</p>
                                      <h4 id="${coms1.id}" style="margin-left:670px; display:inline; color:#2b2b2b; cursor:pointer;" onclick="deleteComment(this)">Видалити</h4>
                                <br>
                                <br>
                            </div>
                        </c:forEach>
                    </div>

                    <c:choose>
                        <c:when test="${cookie['user_id'].getValue()==null}">
                            <c:set var="userToComId" value="0"></c:set>
                        </c:when>
                        <c:otherwise>
                            <c:set var="userToComId" value="${Integer.valueOf(cookie['user_id'].getValue()).intValue()}"></c:set>
                        </c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${cookie['admin'].getValue()==null}">
                            <c:set var="isUserAdmin" value="0"></c:set>
                        </c:when>
                        <c:otherwise>
                            <c:set var="isUserAdmin" value="${Integer.valueOf(cookie['admin'].getValue()).intValue()}"></c:set>
                        </c:otherwise>
                    </c:choose>

                    <div style="margin-top:40px;">
                        <h2 style="padding:30px; margin-top:20px; text-align:center; background-color:#f7cc54;">Усі коментарі за популярністтю</h2>
                        <c:forEach var="coms2" items="${bookComments}">
                            <div id="${coms2.id}fullCom" style="margin:auto; background-color:#f7cc54; text-align:center; max-width:800px; border-radius:30px; margin-top:30px;">
                                    <br>
                                    <h4 style="display:inline;"> <a style="text-decoration: none; color:black;" href="http://localhost:9191/profile/user/${coms2.user.nickname}"> ${coms2.user.nickname}</a></h4>
                                    <c:choose>
                                        <c:when test="${coms2.user.id==userToComId || isUserAdmin==1}">
                                            <h4 id="${coms2.id}" style="margin-left:670px; display:inline; color:#2b2b2b; cursor:pointer;" onclick="deleteComment(this)">Видалити</h4>
                                        </c:when>
                                        <c:otherwise>
                                        </c:otherwise>
                                    </c:choose>
                                    <p>${coms2.body}</p>
                                    <div style="text-align:center; font-size:18px;">
                                    <c:set var="isNotPrintedLike" value="true"></c:set>
                                    <c:forEach var="react" items="${coms2.reactions}">
                                        <c:choose>
                                           <c:when test="${react.user.id==userToComId}">
                                               <c:choose>
                                                   <c:when test="${react.like}">
                                                        <p class="reactions" id="${coms2.id}tu" data-like-comId="${coms2.id}" style="display:inline; cursor:pointer;" onclick="sendLike(this)">👍🏿</p>
                                                        <c:set var="isNotPrintedLike" value="false"></c:set>
                                                   </c:when>
                                                   <c:otherwise>
                                                   </c:otherwise>
                                               </c:choose>
                                           </c:when>
                                           <c:otherwise>
                                           </c:otherwise>
                                        </c:choose>
                                    </c:forEach>

                                    <c:choose>
                                        <c:when test="${isNotPrintedLike==true}">
                                             <p class="reactions" id="${coms2.id}tu" data-like-comId="${coms2.id}" style="display:inline; cursor:pointer;" onclick="sendLike(this)">👍</p>
                                        </c:when>
                                        <c:otherwise>
                                        </c:otherwise>
                                    </c:choose>

                                    <p id="${coms2.id}l" style="display:inline; margin-right:20px;">${coms2.like}</p>
                                    <c:set var="isNotPrintedDislike" value="true"></c:set>
                                    <c:forEach var="react" items="${coms2.reactions}">
                                        <c:choose>
                                           <c:when test="${react.user.id==userToComId}">
                                               <c:choose>
                                                   <c:when test="${react.dislike}">
                                                        <p class="reactions" id="${coms2.id}td" data-dislike-comId="${coms2.id}" style="display:inline; cursor:pointer;"onclick="sendDislike(this)">👎🏿</p>
                                                        <c:set var="isNotPrintedDislike" value="false"></c:set>
                                                   </c:when>
                                                   <c:otherwise>
                                                   </c:otherwise>
                                               </c:choose>
                                           </c:when>
                                           <c:otherwise>
                                           </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <c:choose>
                                        <c:when test="${isNotPrintedDislike==true}">
                                              <p class="reactions" id="${coms2.id}td" data-dislike-comId="${coms2.id}" style="display:inline; cursor:pointer;"onclick="sendDislike(this)">👎</p>
                                        </c:when>
                                        <c:otherwise>
                                        </c:otherwise>
                                    </c:choose>
                                      <p id="${coms2.id}d" style="display:inline;">${coms2.dislike}</p>
                                    </div>
                                <br>
                                <br>
                            </div>
                        </c:forEach>
                    </div>
                       <br>
                       <br>
                </div>
                <br>
                <br>
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
        <div id="removeAccept" style="display:none;">
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
        var toChangeMarks = "0";
        var uId = 0;
        var comment;

        function getProfile(){
            window.location.replace("http://localhost:9191/profile/user/${cookie["nick"].getValue()}");
        }

        function load(){
        if(window.location.href=="http://localhost:9005/books/${id}"){
            window.location.replace("http://localhost:9191/books/${id}");
        }

          let nick = getCookie("nick");
          let id = getCookie("user_id");
          uId = id;
          if (nick =="" || id == "") {
            document.getElementById("regMessage").style.display = "block";
            const reactions = document.getElementsByClassName("reactions");
            for (let i = 0; i < reactions.length; i++) {
              reactions[i].setAttribute("onclick","");
              reactions[i].style.cursor="";
            }
               return;
          } else {
            document.getElementById("exitB").style.display = "inline";
            document.getElementById("profile").style.display = "inline";
            document.getElementById("enterB").style.display = "none";
            document.getElementById("regB").style.display = "none";
            document.getElementById("forComment").style.display = "block";
             if(${isScored}){
                 document.getElementById("alreadyMessage").style.display = "block";
              }else{
                 document.getElementById("scores").style.display = "block";
                 toChangeMarks = "1";
              }
             if(${isCommented}){
                document.getElementById("userComs").style.display = "block";
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


         function addScore(){
            var buffer = document.getElementById('comMark');
            var comMark = buffer.options[buffer.selectedIndex].value;

                buffer = document.getElementById('textMark');
            var textMark = buffer.options[buffer.selectedIndex].value;

                buffer = document.getElementById('storyMark');
            var storyMark = buffer.options[buffer.selectedIndex].value;

            window.location.replace("http://localhost:9191/books/${id}?comM="+comMark+"&txtM="+textMark+"&stM="+storyMark+"&toChange="+toChangeMarks);
         }

         function changeMarks(){
            toChangeMarks ="1";
            document.getElementById("alreadyMessage").style.display = "none";
            document.getElementById("scores").style.display = "block";
         }

         function sendComment(){
             $.ajax({
                 type: "POST",
                 url: "http://localhost:9191/books/${id}",
                 data: "comment=" + $('#comment').val()+"&uid="+uId,
                 success: function(response){
                 if(response=="BAD"){
                        $('#sendResponse').html(decodeURIComponent("Помилка!"));
                    }else if(response=="alreadyCommented"){
                         $('#sendResponse').html(decodeURIComponent("Ви вже залишили коментар!"));
                    }else{
                        $('#sendResponse').html(decodeURIComponent("Надіслано!"));
                        $('#comment').val("");
                    }
                 },
             });
            }

            function sendLike(like){
                $.ajax({
                    type: "POST",
                    url: "http://localhost:9191/books/${id}",
                    data: "like=true&uid="+uId+"&comId="+like.getAttribute("data-like-comId"),
                    success: function(response){
                    if(response=="BAD"){
                        return;
                       }
                    if(response=="OK"){
                        like.innerHTML="👍🏿";
                        var newMark = parseInt(document.getElementById(like.getAttribute("data-like-comId")+"l").innerHTML)+1;
                        document.getElementById(like.getAttribute("data-like-comId")+"l").innerHTML=newMark;
                    }if(response=="removed"){
                         like.innerHTML="👍";
                         var newMark = parseInt(document.getElementById(like.getAttribute("data-like-comId")+"l").innerHTML)-1;
                         document.getElementById(like.getAttribute("data-like-comId")+"l").innerHTML=newMark;
                     }if(response=="change"){
                         document.getElementById(like.getAttribute("data-like-comId")+"td").innerHTML="👎";
                         like.innerHTML="👍🏿";
                         var newDisMark = parseInt(document.getElementById(like.getAttribute("data-like-comId")+"d").innerHTML)-1;
                         var newLikeMark = parseInt(document.getElementById(like.getAttribute("data-like-comId")+"l").innerHTML)+1;
                         document.getElementById(like.getAttribute("data-like-comId")+"d").innerHTML=newDisMark;
                         document.getElementById(like.getAttribute("data-like-comId")+"l").innerHTML=newLikeMark;
                      }
                    },
                });
               }


               function sendDislike(dislike){
                   $.ajax({
                       type: "POST",
                       url: "http://localhost:9191/books/${id}",
                       data: "like=false&uid="+uId+"&comId="+dislike.getAttribute("data-dislike-comId"),
                       success: function(response){
                        if(response=="BAD"){
                            return;
                           }
                        if(response=="OK"){
                            dislike.innerHTML="👎🏿";
                            var newMark = parseInt(document.getElementById(dislike.getAttribute("data-dislike-comId")+"d").innerHTML)+1;
                            document.getElementById(dislike.getAttribute("data-dislike-comId")+"d").innerHTML=newMark;
                        }if(response=="removed"){
                             dislike.innerHTML="👎";
                             var newMark = parseInt(document.getElementById(dislike.getAttribute("data-dislike-comId")+"d").innerHTML)-1;
                             document.getElementById(dislike.getAttribute("data-dislike-comId")+"d").innerHTML=newMark;
                         }
                         if(response=="change"){
                            document.getElementById(dislike.getAttribute("data-dislike-comId")+"tu").innerHTML="👍";
                            dislike.innerHTML="👎🏿";
                            var newDisMark = parseInt(document.getElementById(dislike.getAttribute("data-dislike-comId")+"d").innerHTML)+1;
                            var newLikeMark = parseInt(document.getElementById(dislike.getAttribute("data-dislike-comId")+"l").innerHTML)-1;
                            document.getElementById(dislike.getAttribute("data-dislike-comId")+"d").innerHTML=newDisMark;
                            document.getElementById(dislike.getAttribute("data-dislike-comId")+"l").innerHTML=newLikeMark;
                         }
                       },
                   });
                  }

            function deleteComment(myComment){
                document.getElementById("removeAccept").style.display="block";
                comment = myComment;
                document.getElementById('main').style="opacity:0.75";
                }

            function acceptRemove(){
                $.ajax({
                    type: "POST",
                    url: "http://localhost:9191/books/${id}",
                    data: "deleteMyComment=true&comId="+comment.getAttribute("id"),
                    success: function(response){
                     if(response=="BAD"){
                         return;
                        }
                     if(response=="OK"){
                        closeAccept();
                         document.getElementById(comment.getAttribute("id")+"fullCom").style.display="none";
                         document.getElementById(comment.getAttribute("id")+"myFullCom").style.display="none";
                     }
                    },
                });
            }

            function closeAccept(){
                document.getElementById("removeAccept").style.display="none";
                document.getElementById('main').style="opacity:1";
            }
    </script>
</html>


