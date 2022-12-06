<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    <head>
        <meta charset="utf-8">
        <title>Налаштування пана ${user.nickname}</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    </head>
    <body id="body" style="margin:0px; font-family:verdana;"onload="load()">
    <div style="margin-left:50px;">
        <h2>Тут ви можете змінити свій профілю</h2>
        <span style="margin-left:700px; font-size:100px; cursor:pointer; display:inline; position:absolute; margin-top:-105px;"> <a style="color:black; text-decoration: none;" href="http://localhost:9191/profile/user/${user.nickname}">&larr;</a></span>
        <br>
            <form:form action="http://localhost:9191/updateUser?id=${user.id}" method="post" modelAttribute="user">
                <p>Нікнейм</p>
                <form:input id="nick" path="nickname" style="margin-bottom:20px; margin-top:5px; width:300px; height:20px; text-align:center;" type="text" placeholder="Вигадайте нікнейм" onkeyup="checkNick()"/>
                <a style="font-size:14px;">*лише латинські маленькі літери, максимальна довжена - 30 літер</a>
                <br>
                <br>
                <p>Електронна пошта</p>
                <form:input id="mail" path="email" style="margin-bottom:20px; width:300px; height:20px; text-align:center;" type="text" placeholder="Укажіть пошту" onkeyup="checkMail()"/>
                <br>
                <br>
                <p>Пароль</p>
                <form:input id="passw" path="password" style="margin-bottom:20px; width:300px; height:20px; text-align:center;" type="password" placeholder="Вигадайте пароль" onkeyup="checkPassw()"/>
                <br>
                <br>
                <p>Повторіть пароль</p>
                <input id="repPassw" style="margin-bottom:20px; width:300px; height:20px; text-align:center;" type="password" placeholder="Повторіть пароль" onkeyup="checkPassw()"/>
                <p>Опис профілю</p>
                <form:input path="description" value="${user.description}" style="margin-bottom:20px; width:300px; height:20px; height:70px; text-align:center;" type="text" placeholder="Вигадайте опис прифілю"/>
                <a>*необов'язково</a>
                <br>
                <a style="font-size:12px; margin-right:300px;">*кнопка стане активною після коректного заповнення полів</a>
                <br>
                <input id="regButton" style="margin-top:10px; width:310px; height:30px; background-color:grey;" type="submit" disabled value="Змінити" />
                <a style="color:red; margin-right:100px;">${param.error}</a>
            </form:form>
            <br>
            <br>
        <input onclick="deleteUser()" id="delButton" style="width:150px; height:30px; margin-left:70px; background-color:#f76579; cursor:pointer;" type="button" value="Видалити акаунт" />
        <br>
        <br>
    </div>
    </body>
    <script>

        var nickCheck = false;
        var emailCkeck = false;
        var passwCheck = false;
        var isAuthPass = false;
        var isAuthNick = false;

        function load(){
            if(window.location.href!="http://localhost:9191/profile/user/${user.nickname}/settings"){
                window.location.replace("http://localhost:9191/profile/user/${user.nickname}/settings");
            }
          let nick = getCookie("nick");
          let id = getCookie("user_id");
          if (nick =="" || id == "") {
                window.location.replace("http://localhost:9191/profile");
                return;
            }
          checkNick();
          checkMail();
          checkPassw();
          validationCheck();
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

       function deleteUser(){
       document.cookie ='user_id=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
       document.cookie ='nick=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
       document.cookie ='admin=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
             $.ajax({
                 type: "POST",
                 url: "http://localhost:9191/profile/user/${user.id}/remove",
                 success: function(response){
                  if(response=="BAD"){
                      return;
                     }
                  if(response=="OK"){
                    window.location.replace("http://localhost:9191/profile");
                  }
                 },
             });
       }

    </script>
</html>