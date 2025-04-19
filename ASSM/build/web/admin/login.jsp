<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="../part/link.html" %>
        <link rel="stylesheet" href="../src/css/main.css">
        <title>Petto - Admin</title>
        <style>

            .admin-area{
                align-items: center;
            }

            .admin-logo{
                width: 50%;
                display: block;
                margin-left: auto;
                margin-right: auto;
            }

            .admin-login-left {
                text-align: center;
            }

            .admin-submitbtn{
                width: 100%;
                padding: 5px 0;
                border: none;
                background-color: #99B9FF;
            }

            .admin-login-top h3{
                font-family: var(--font1);
                font-weight: 600;
            }

            .admin-login-left h3{
                letter-spacing: 4px;
                font-family: serif;
                font-weight: 600;
            }

            #password-eye{
                background-color: white;
            }
            .input-group-text-eye{
                display: flex;
                align-items: center;
                padding: 0.375rem 0.75rem;
                font-size: 1rem;
                font-weight: 400;
                line-height: 1.5;
                color: #212529;
                text-align: center;
                white-space: nowrap;
                border: 1px solid #ced4da;
                border-radius: 0.375rem;
            }

            .admin-back{
                align-items: center;
                margin-left: auto;
                margin-right: auto;
                padding-top: 30px;
                justify-content: center;
                cursor:pointer;
            }

            .admin-back a{
                text-decoration: none;
                color: black;
                position:relative;
            }

            .admin-back a i{
                padding-right:30px;
            }

            .admin-back a:after {
                content: '';
                position: absolute;
                width: 75%;
                transform: scaleX(0);
                height: 2px;
                bottom: 0;
                left: 0;
                background-color: #0087ca;
                transform-origin: bottom right;
                transition: transform 0.25s ease-out;
                margin-left: 45px;
            }

            .admin-back a:hover:after {
                transform: scaleX(1);
                transform-origin: bottom left;
            }
        </style>
    </head>
    <body>
        <div>
            <div class="row admin-area g-0">
                <div class="col-7">
                    <img src="../src/img/adminLogo.png" class="admin-logo">
                    <div class="admin-login-left">
                        <h3 class="py-4">Welcome Back To Admin !</h3>
                    </div>
                </div>
                <div class="col-4">
                    <div class="admin-login-top">
                        <h3>Welcome Back To Admin !</h3>
                        <p style="letter-spacing: 1px;">Start managing your company finance fast and efficiently</p>
                    </div>
                    <div class="admin-login-bottom">
                        <form action="adminLoginServlet" method="POST">
                            <div class="input-group mb-3">
                                <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                                <input type="text" class="form-control" placeholder="Username" id="username" name="username" style="padding-right: 48px;">
                            </div>
                            <div class="input-group mb-3">
                                <span class="input-group-text"><i class="fa-solid fa-unlock"></i></span>
                                <input type="password" class="form-control" placeholder="Password" id="admin-pass" name="password" style="border-right: none; padding-left: 18px;">
                                <span class="input-group-text-eye"><i class="fa-solid fa-eye-slash" id="togglePassword"></i></span>
                            </div>
                            <% if(session.getAttribute("loginstatus") != null && session.getAttribute("loginstatus").equals("failed")) { %>
                            <div style="text-align:center;color:red;font-weight:500;opacity:0.7;font-size:14px;"><p>Wrong Username/Password</p></div>
                            <%}%>
                            <input type="submit" class="admin-submitbtn" value="Sign In">
                        </form>
                    </div>
                    <div class="admin-back d-flex">
                        <a href="../index.jsp"><i class="fa-solid fa-arrow-left-long"></i>Back To Petto Page </a>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="../part/script.html" %>
        <script>
            const togglePassword = document.querySelector('#togglePassword');
            const password = document.querySelector('#admin-pass');

            togglePassword.addEventListener('click', () => {
                const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
                password.setAttribute('type', type);
                this.classList.toggle('fa-solid fa-eye');
            });
        </script>
    </body>

</html>
