package com.alkewallet.controller;

import com.alkewallet.model.User;
import com.alkewallet.service.WalletService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/deposit")
public class DepositServlet extends HttpServlet {
    private final WalletService walletService = WalletService.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        request.setAttribute("user", user);
        request.setAttribute("account", user.getAccount());
        request.getRequestDispatcher("/deposit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String amountStr = request.getParameter("amount");
        String note = request.getParameter("note");

        double amount = 0.0;
        try {
            amount = Double.parseDouble(amountStr.replace(",", "."));
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Ingresa un monto numérico válido.");
            request.setAttribute("user", user);
            request.setAttribute("account", user.getAccount());
            request.getRequestDispatcher("/deposit.jsp").forward(request, response);
            return;
        }

        if (amount <= 0) {
            request.setAttribute("errorMessage", "El monto a depositar debe ser mayor a $0.");
            request.setAttribute("user", user);
            request.setAttribute("account", user.getAccount());
            request.getRequestDispatcher("/deposit.jsp").forward(request, response);
            return;
        }

        boolean success = walletService.deposit(user, amount, note);
        if (success) {
            request.getSession().setAttribute("flashSuccess", String.format("¡Depósito exitoso de $%.2f!", amount));
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            request.setAttribute("errorMessage", "Ocurrió un error al procesar el depósito.");
            request.setAttribute("user", user);
            request.setAttribute("account", user.getAccount());
            request.getRequestDispatcher("/deposit.jsp").forward(request, response);
        }
    }
}
