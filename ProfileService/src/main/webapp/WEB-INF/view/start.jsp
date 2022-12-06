<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    <head>
        <meta charset="utf-8">
        <title>Обреіть сервіс</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <style>
            html, body{
            height:100%
            }
        </style>
    </head>
    <body style="margin:0px; font-family:verdana; user-select: none; background-color:grey" onload="load()">
        <div id="main" style="height:100%;">
                <div style="display: flex; width:100%; height:100px; background-color:#027a32; text-align:center; position:fixed; z-index: 1;">
                    <div style="width:75%; margin-top:24px; text-align:right;">
                        <h1 style="display:inline; margin-top:200px; font-size:40px; color:white;">ОЦІНАТЬ ВАШІ УЛЮБЛЕНІ ПРОДУКТИ МИСТЕЦТВА</h1>
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
                        <input id="exitB"
                               style="width:200px; height:40px; font-size:18px; margin-left:10px; margin-top:30px; cursor:pointer; display:none;"
                               type="button" value="Вийти" onclick="exit()"/>
                    </div>
                </div>
            <div style="display: flex; height:100%;">

                <div style="width:33%; min-height:100%; background-color:#c92037; text-align:center; z-index: 0;">
                    <h1 style="z-index: 1; margin-top:460px; font-size:100px; cursor:pointer;"><a style="color:white;" href="http://localhost:9191/games">ІГРИ</a></h1>
                </div>
                <div style="width:33%; min-height:100%; background-color:#2319bd; text-align:center;">
                    <h1 style="z-index: 1; margin-top:460px; font-size:100px; cursor:pointer;"><a style="color:white;" href="http://localhost:9191/films">ФІЛЬМИ</a></h1>
                </div>
                <div style="width:35%; min-height:100%; background-color:#3ca314; text-align:center;">
                    <h1 style="z-index: 1;margin-top:460px; font-size:100px; cursor:pointer;"><a style="color:white;" href="http://localhost:9191/books">КНИГИ</a></h1>
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

        function getProfile(){
            window.location.replace("http://localhost:9191/profile/user/${cookie["nick"].getValue()}");
        }


        function load(){
          if(window.location.href=="http://localhost:9003/profile"){
              window.location.replace("http://localhost:9191/profile");
          }
          let nick = getCookie("nick");
          let id = getCookie("user_id");
          if (nick =="" || id == "") {
               return;
          } else {
            document.getElementById("exitB").style.display = "inline";
            document.getElementById("profile").style.display = "inline";
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
                    document.getElementById('main').style="opacity:1; height:100%;";
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
                 document.getElementById('main').style="opacity:1;height:100%;";
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

       function exit() {
           document.cookie ='user_id=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
           document.cookie ='nick=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
           document.cookie ='admin=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
           window.location.replace(window.location.href);
         }

    </script>
</html>


