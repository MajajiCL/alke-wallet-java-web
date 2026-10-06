<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alke Wallet - Iniciar Sesión</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <style>
        .login-hero {
            background: linear-gradient(180deg, var(--primary-blue) 0%, #3B92DE 100%);
            color: white;
            text-align: center;
            padding: 60px 24px 40px;
            border-bottom-left-radius: 40px;
            border-bottom-right-radius: 40px;
        }
        .login-logo {
            width: 80px;
            height: 80px;
            background: white;
            border-radius: 24px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.12);
            margin-bottom: 16px;
        }
        .login-container {
            padding: 30px 24px;
        }
        .demo-box {
            background: #EAF4FD;
            border-left: 4px solid var(--dark-blue);
            padding: 14px 16px;
            border-radius: 12px;
            font-size: 13px;
            margin-top: 24px;
            line-height: 1.5;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-hero">
            <div class="login-logo">💳</div>
            <h1 class="brand-title" style="font-size: 28px; margin-bottom: 8px;">AlkeWallet</h1>
            <p style="font-size: 15px; opacity: 0.9;">El lugar más seguro para tu dinero</p>
        </div>

        <div class="login-container">
            <% String error = (String) request.getAttribute("errorMessage"); %>
            <% if (error != null) { %>
                <div class="alert alert-error">
                    <%= error %>
                </div>
            <% } %>

            <form action="<%= request.getContextPath() %>/login" method="POST" class="form-card">
                <div class="form-group">
                    <label class="form-label" for="email">Correo Electrónico</label>
                    <input type="email" id="email" name="email" class="form-input" 
                           placeholder="tu.correo@ejemplo.com" 
                           value="<%= request.getAttribute("enteredEmail") != null ? request.getAttribute("enteredEmail") : "amanda@alkewallet.com" %>" 
                           required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="password">Contraseña</label>
                    <input type="password" id="password" name="password" class="form-input" 
                           placeholder="••••••••" value="1234" required>
                </div>

                <button type="submit" class="btn-submit btn-blue" style="margin-top: 10px;">
                    Iniciar Sesión
                </button>
            </form>

            <div class="demo-box">
                <strong>💡 Credenciales de demostración:</strong><br>
                <b>Email:</b> <code>amanda@alkewallet.com</code> o <code>vanne@alkewallet.com</code><br>
                <b>Contraseña:</b> <code>1234</code>
            </div>
        </div>
    </div>
</body>
</html>
