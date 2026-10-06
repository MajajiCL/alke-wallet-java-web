<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.alkewallet.model.User" %>
<%@ page import="com.alkewallet.model.Account" %>
<%
    User user = (User) request.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    Account account = user.getAccount();
    String error = (String) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alke Wallet - Depositar Fondos</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="container">
        <!-- Barra de navegación -->
        <div class="nav-back-bar">
            <a href="<%= request.getContextPath() %>/home" class="back-link">←</a>
            <div class="page-nav-title">Depositar Fondos</div>
        </div>

        <div class="content-section">
            <!-- Tarjeta de Saldo Actual -->
            <div style="background: #E8F8DE; border: 1px solid #C8E6C9; padding: 16px 20px; border-radius: 14px; margin-bottom: 24px;">
                <div style="font-size: 13px; color: #2E7D32; font-weight: 600; text-transform: uppercase;">Saldo Actual en Cuenta</div>
                <div style="font-size: 26px; font-weight: 800; color: #1B5E20; margin-top: 4px;"><%= account.getFormattedBalance() %></div>
            </div>

            <% if (error != null) { %>
                <div class="alert alert-error">
                    <%= error %>
                </div>
            <% } %>

            <form action="<%= request.getContextPath() %>/deposit" method="POST" class="form-card">
                <div class="form-group">
                    <label class="form-label" for="amount">Monto a Depositar</label>
                    <div class="amount-input-wrapper">
                        <span class="amount-currency">$</span>
                        <input type="number" id="amount" name="amount" class="form-input" 
                               step="0.01" min="0.01" placeholder="0.00" required autofocus>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" for="note">Nota o Concepto (Opcional)</label>
                    <input type="text" id="note" name="note" class="form-input" 
                           placeholder="Ej. Depósito nómina, ahorro mensual...">
                </div>

                <button type="submit" class="btn-submit btn-green" style="margin-top: 10px;">
                    Confirmar Depósito
                </button>
            </form>
        </div>
    </div>
</body>
</html>
