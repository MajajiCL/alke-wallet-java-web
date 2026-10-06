<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.alkewallet.model.User" %>
<%@ page import="com.alkewallet.model.Account" %>
<%@ page import="com.alkewallet.model.Transaction" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) request.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    Account account = user.getAccount();
    List<Transaction> transactions = account.getTransactions();
    String flashSuccess = (String) session.getAttribute("flashSuccess");
    if (flashSuccess != null) {
        session.removeAttribute("flashSuccess");
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alke Wallet - Inicio</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="container">
        <!-- Header con Balance -->
        <div class="header-curve">
            <div class="header-top">
                <div class="brand-title">AlkeWallet</div>
                <div class="user-badge">
                    <div class="user-avatar"><%= user.getName().substring(0, 1) %></div>
                    <a href="<%= request.getContextPath() %>/logout" class="logout-link">Salir</a>
                </div>
            </div>

            <div class="balance-card">
                <div class="balance-label">Balance Total Disponible</div>
                <div class="balance-amount"><%= account.getFormattedBalance() %></div>
                <div class="account-num">Cuenta: <%= account.getAccountNumber() %> • <%= user.getName() %></div>
            </div>
        </div>

        <!-- Botones de Acción (Requerimiento: Depósitos y Retiros) -->
        <div class="action-grid">
            <a href="<%= request.getContextPath() %>/deposit" class="btn-action btn-green">
                <span>➕</span> Depositar
            </a>
            <a href="<%= request.getContextPath() %>/withdraw" class="btn-action btn-blue">
                <span>➖</span> Retirar
            </a>
        </div>

        <!-- Contenido / Transacciones -->
        <div class="content-section">
            <% if (flashSuccess != null) { %>
                <div class="alert alert-success">
                    <%= flashSuccess %>
                </div>
            <% } %>

            <div class="section-header">
                <h2 class="section-title">Últimas transacciones</h2>
                <a href="<%= request.getContextPath() %>/transactions" class="section-link">Ver todas</a>
            </div>

            <div class="transaction-list">
                <% if (transactions == null || transactions.isEmpty()) { %>
                    <div style="text-align: center; padding: 40px 20px; color: var(--text-secondary);">
                        <div style="font-size: 40px; margin-bottom: 10px;">📄</div>
                        <p>No hay transacciones registradas aún.</p>
                        <p style="font-size: 13px; margin-top: 5px;">¡Realiza tu primer depósito!</p>
                    </div>
                <% } else { %>
                    <% 
                    int max = Math.min(transactions.size(), 5);
                    for (int i = 0; i < max; i++) { 
                        Transaction tx = transactions.get(i);
                        boolean isDep = "DEPOSIT".equalsIgnoreCase(tx.getType());
                    %>
                        <div class="transaction-item">
                            <div class="tx-icon-box <%= isDep ? "tx-deposit" : "tx-withdraw" %>">
                                <%= isDep ? "↓" : "↑" %>
                            </div>
                            <div class="tx-info">
                                <div class="tx-title"><%= tx.getDescription() %></div>
                                <div class="tx-date"><%= tx.getFormattedDate() %></div>
                            </div>
                            <div class="tx-amount <%= isDep ? "amount-positive" : "amount-negative" %>">
                                <%= tx.getFormattedAmount() %>
                            </div>
                        </div>
                    <% } %>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html>
