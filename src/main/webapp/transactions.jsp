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
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alke Wallet - Historial de Transacciones</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="container">
        <!-- Barra de navegación -->
        <div class="nav-back-bar">
            <a href="<%= request.getContextPath() %>/home" class="back-link">←</a>
            <div class="page-nav-title">Todas las Transacciones</div>
        </div>

        <div class="content-section">
            <div style="background: var(--bg-light); padding: 14px 18px; border-radius: 12px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center;">
                <span style="font-size: 13px; color: var(--text-secondary);">Total movimientos:</span>
                <span style="font-weight: 700; color: var(--dark-blue);"><%= transactions != null ? transactions.size() : 0 %></span>
            </div>

            <div class="transaction-list">
                <% if (transactions == null || transactions.isEmpty()) { %>
                    <div style="text-align: center; padding: 40px 20px; color: var(--text-secondary);">
                        <div style="font-size: 40px; margin-bottom: 10px;">📄</div>
                        <p>No hay transacciones registradas.</p>
                    </div>
                <% } else { %>
                    <% for (Transaction tx : transactions) { 
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
