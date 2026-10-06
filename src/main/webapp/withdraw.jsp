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
    <title>Alke Wallet - Retirar Fondos</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="container">
        <!-- Barra de navegación -->
        <div class="nav-back-bar">
            <a href="<%= request.getContextPath() %>/home" class="back-link">←</a>
            <div class="page-nav-title">Retirar Fondos</div>
        </div>

        <div class="content-section">
            <!-- Tarjeta de Saldo Disponible -->
            <div style="background: #EAF4FD; border: 1px solid #BBDEFB; padding: 16px 20px; border-radius: 14px; margin-bottom: 24px;">
                <div style="font-size: 13px; color: #1565C0; font-weight: 600; text-transform: uppercase;">Saldo Disponible para Retiro</div>
                <div style="font-size: 26px; font-weight: 800; color: #0D47A1; margin-top: 4px;"><%= account.getFormattedBalance() %></div>
            </div>

            <% if (error != null) { %>
                <div class="alert alert-error">
                    <%= error %>
                </div>
            <% } %>

            <form action="<%= request.getContextPath() %>/withdraw" method="POST" class="form-card">
                <div class="form-group">
                    <label class="form-label" for="amount">Monto a Retirar</label>
                    <div class="amount-input-wrapper">
                        <span class="amount-currency">$</span>
                        <input type="number" id="amount" name="amount" class="form-input" 
                               step="0.01" min="0.01" max="<%= account.getBalance() %>" 
                               placeholder="0.00" required autofocus>
                    </div>
                    <small style="color: var(--text-secondary); font-size: 12px; margin-top: 4px; display: block;">
                        Máximo a retirar: <%= account.getFormattedBalance() %>
                    </small>
                </div>

                <div class="form-group">
                    <label class="form-label" for="note">Motivo o Destino del Retiro (Opcional)</label>
                    <input type="text" id="note" name="note" class="form-input" 
                           placeholder="Ej. Transferencia cuenta externa, pago de servicios...">
                </div>

                <button type="submit" class="btn-submit btn-blue" style="margin-top: 10px;">
                    Confirmar Retiro
                </button>
            </form>
        </div>
    </div>
</body>
</html>
